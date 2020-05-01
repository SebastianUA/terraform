#!/usr/bin/python3
# -*- coding: utf-8 -*-

import argparse
import datetime
import time
import csv
import json
import logging
import urllib3
import os
from gzip import GzipFile
from io import BytesIO, StringIO

import boto3
import botocore
from botocore.config import Config

# Initialize Logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

"""
Can Override the global variables using Lambda Environment Parameters
"""
globalVars = {}
globalVars['esIndexPrefix'] = "s3-to-es-"
globalVars['esIndexDocType'] = "s3_to_es_docs"


def s3_connector(aws_auth):
    if (aws_auth['role_name'] is None or aws_auth['role_name'] == "None") \
            and (aws_auth['role_session'] is None or aws_auth['role_session'] == "None"):
        try:
            session = boto3.session.Session(profile_name=aws_auth['profile_name'])
            # Will retry any method call at most 3 time(s)
            s3 = session.client(service_name=aws_auth['client'],
                                region_name=aws_auth['region'],
                                config=Config(retries={'max_attempts': 3})
                                )
            return s3
        except Exception as err:
            print("Failed to create a boto3 client connection to S3:\n", str(err))
            logger.error('ERROR: Failed to create a boto3 client connection to S3')
            return False
    elif (aws_auth['profile_name'] is None or aws_auth['profile_name'] == "None") \
            and (aws_auth['role_name'] is not None or aws_auth['role_name'] != "None") \
            and (aws_auth['role_session'] is not None or aws_auth['role_session'] != "None"):
        try:
            session = boto3.session.Session()
            sts = session.client(service_name='sts',
                                 region_name=aws_auth['region'],
                                 config=Config(retries={'max_attempts': 3})
                                 )

            assumed_role_object = sts.assume_role(
                RoleArn="{0}".format(aws_auth['role_name']),
                RoleSessionName='{0}'.format(aws_auth['role_session'])
            )
            # can be used ay name, but need to add restriction for the name!
            s3 = session.client(aws_access_key_id=assumed_role_object['Credentials']['AccessKeyId'],
                                aws_secret_access_key=assumed_role_object['Credentials']['SecretAccessKey'],
                                aws_session_token=assumed_role_object['Credentials']['SessionToken'],
                                service_name=aws_auth['client'],
                                region_name=aws_auth['region'],
                                config=Config(retries={'max_attempts': 3})
                                )

            return s3
        except Exception as err:
            print("Failed to create a boto3 client connection to S3:\n", str(err))
            logger.error('ERROR: Failed to create a boto3 client connection to S3')
            return False
    else:
        print('Please use/set [--profile-name] or [--role-name] with [--role-session]')
        return False


def s3_bucket(aws_auth, s3_bucket_name):
    s3_bucket_status = False
    s3 = s3_connector(aws_auth)
    if s3:
        try:
            s3.head_bucket(Bucket=s3_bucket_name)
            print("A bucket {} is already exists!".format(s3_bucket_name))
            s3_bucket_status = True
            return s3_bucket_status
        except botocore.exceptions.ClientError as e:
            error_code = int(e.response['Error']['Code'])
            if error_code == 403:
                print("Private {} bucket. Forbidden Access!".format(s3_bucket_name))
                logger.error('ERROR: Private {0} Bucket. Forbidden Access!'.format(s3_bucket_name))
            elif error_code == 404:
                print("The {} bucket does not exist!".format(s3_bucket_name))
                logger.error('ERROR: The {0} bucket does not exist!'.format(s3_bucket_name))
            s3_bucket_status = False
            return s3_bucket_status
    else:
        exit(-1)

    return s3_bucket_status


def s3_objects(aws_auth, s3_bucket_name):
    s3objects = []

    s3 = s3_connector(aws_auth)
    bucket_name = s3_bucket(aws_auth, s3_bucket_name)
    if bucket_name:
        try:
            for key in s3.list_objects(Bucket=s3_bucket_name)['Contents']:
                # print(key['Key'])
                key_name = key['Key']
                if (key_name.endswith('.gz')) or (key_name.endswith('.tar.gz')):
                    retr = s3.get_object(Bucket=s3_bucket_name, Key=key_name)
                    bytestream = BytesIO(retr['Body'].read())
                    content = GzipFile(None, 'rb', fileobj=bytestream).read().decode('utf-8')
                    s3objects.append(content)
                else:
                    data = s3.get_object(Bucket=s3_bucket_name, Key=key_name)
                    contents = data['Body'].read()
                    s3objects.append(contents)

                logger.info('SUCCESS: Retrieved object(s) from S3 {0} bucket'.format(s3_bucket_name))
        except Exception as e:
            print(e)
            logger.error('ERROR: I could not retrieved object(s) from S3 {0} bucket'.format(s3_bucket_name))

    return s3objects


def sending_data_to_elastisearch(es_url, docData):
    # Index each line to ES Domain
    index_name = globalVars['esIndexPrefix'] + str(datetime.date.today().year) + '-' + str(datetime.date.today().month)
    elastic_searh_url = es_url + '/' + index_name + '/' + globalVars['esIndexDocType']
    try:
        headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}
        http = urllib3.PoolManager()
        response = http.request('POST',
                                elastic_searh_url,
                                body=json.dumps(docData),
                                headers=headers,
                                retries=False,
                                timeout=30)

        # print('Response status: ', response.status, "\nResponse data: ", response.data.decode('utf-8'))

        logger.error('ERROR [response status]: {0}'.format(response.status))

        if response.status == 201:
            logger.info('INFO: Response status: {0}\nResponse data: {1}'.format(response.status,
                                                                                response.data.decode('utf-8')))
            logger.info('INFO: Successfully inserted element into ES')
        elif response.status == 405:
            logger.error('ERROR: Something is wrong with sending DATA: \n\t {}'.format(response.data.decode('utf-8')))
            exit(1)
        else:
            logger.error('FAILURE: Got an error: \n\t {}'.format(response.data.decode('utf-8')))
            exit(1)
    except Exception as e:
        logger.error('ERROR: {0}'.format(str(e)))
        logger.error('ERROR: Unable to index line:"{0}"'.format(str(docData['content'])))
        print(e)
        exit(1)

    return sending_data_to_elastisearch


def pushing_locally(aws_auth, s3_bucket_name, es_url):
    s3objects = s3_objects(aws_auth, s3_bucket_name)
    for obj in s3objects:
        reader = csv.DictReader(StringIO(obj), fieldnames=None, restkey=None, restval=None, dialect='excel')
        for row in reader:
            json_out = json.loads(json.dumps(row))

            docData = {}
            docData['content'] = str(json.dumps(json_out))
            docData['createdDate'] = '{}'.format(datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.%fZ"))

            sending_data_to_elastisearch(es_url, docData)

    return pushing_locally


def lambda_handler(event, context):

    aws_auth = {
        "client": os.environ['aws_boto3_client'],
        "region": os.environ['aws_region'],
        "profile_name": os.environ['aws_profile_name'],
        "role_name": os.environ['aws_role_name'],
        "role_session": os.environ['aws_role_session']
    }

    s3_bucket_name = os.environ['aws_s3_bucket_name']
    es_url = os.environ['elasticsearch_url']

    logger.info("Received event: " + json.dumps(event, indent=2))

    s3objects = s3_objects(aws_auth, s3_bucket_name)

    for obj in s3objects:
        reader = csv.DictReader(StringIO(obj.decode('utf-8')),
                                fieldnames=None,
                                restkey=None,
                                restval=None,
                                dialect='excel')
        for row in reader:
            json_out = json.loads(json.dumps(row))

            docData = {}
            docData['content'] = str(json.dumps(json_out))
            docData['createdDate'] = '{}'.format(datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.%fZ"))

            sending_data_to_elastisearch(es_url, docData)
    logger.info('SUCCESS: Successfully indexed the entire doc into ElastiSearch')

    return {"Status": "AWS Lambda handler has been finished"}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog='python3 script_name.py -h',
                                     usage='python3 script_name.py {ARGS}',
                                     add_help=True,
                                     prefix_chars='--/',
                                     epilog='''created by Vitalii Natarov'''
                                     )
    parser.add_argument('--version', action='version', version='v0.1.0')
    parser.add_argument('--bclient', dest='boto3_client', help='Set boto3 client', default='s3')
    parser.add_argument('--region', dest='region', help='Set AWS region for boto3', default='us-east-1')
    parser.add_argument('--pname', '--profile-name', dest='profile_name', help='Set profile name of AWS',
                        default=None)
    parser.add_argument('--rname', '--role-name', dest='role_name', help='Set role ARN name',
                        default=None)
    parser.add_argument('--rsession', '--role-session', dest='role_session', help='Set role session name',
                        default=None)
    parser.add_argument('--s3-bucket', '--s3bucket', dest='s3_bucket', help='Set S3 bucket name',
                        default="test-s3-to-elastisearch")
    parser.add_argument('--es-url', '--esurl', dest='es_url', help='Set ElastiSerch URL',
                        default="http://localhost:9200")
    parser.add_argument('--lambda', dest='aws_lambda', help='Set lambda usage', default=True)

    results = parser.parse_args()

    boto3_client = results.boto3_client
    region = results.region
    profile_name = results.profile_name
    role_name = results.role_name
    role_session = results.role_session
    s3_bucket_name = results.s3_bucket
    es_url = results.es_url
    aws_lambda = results.aws_lambda

    if aws_lambda == 'True':
        lambda_handler(None, None)
    else:
        start__time = time.time()
        aws_auth = {
            "client": boto3_client,
            "region": region,
            "profile_name": profile_name,
            "role_name": role_name,
            "role_session": role_session
        }

        pushing_locally(aws_auth, s3_bucket_name, es_url)

        end__time = round(time.time() - start__time, 2)
        print("--- %s seconds ---" % end__time)

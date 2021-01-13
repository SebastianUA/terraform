#!/usr/bin/python3
# -*- coding: utf-8 -*-

import json

import boto3
from botocore.config import Config
from sys import stdin, stdout, stderr

def main():
    try:
        query = json.loads(stdin.read())

        aws_auth = {
            "client": query['client'],
            "region": query['region'],
            "profile_name": query['profile_name'],
            "role_name": query['role_name'],
            "role_session": query['role_session'],
            "user_name": query['user_name']
        }
        # stdout.write(json.dumps(aws_auth))
        if (aws_auth['role_name'] is None or aws_auth['role_name'] == "None") \
                and (aws_auth['role_session'] is None or aws_auth['role_session'] == "None"):
            try:
                session = boto3.session.Session(profile_name=aws_auth['profile_name'])
                # Will retry any method call at most 3 time(s)
                iam = session.client(service_name=aws_auth['client'],
                                     region_name=aws_auth['region'],
                                     config=Config(retries={'max_attempts': 3})
                                     )
                try:
                    user_response = iam.get_login_profile(UserName=aws_auth['user_name'])
                    user_name = user_response['LoginProfile']['UserName']
                    iam_user_status = 0
                except Exception as e:
                    user_name = "None"
                    iam_user_status = 1
            except Exception as err:
                # stderr.write('Could not get user:\n' + str(err))
                user_name = "error"
                iam_user_status = 1
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
                iam = session.client(aws_access_key_id=assumed_role_object['Credentials']['AccessKeyId'],
                                     aws_secret_access_key=assumed_role_object['Credentials']['SecretAccessKey'],
                                     aws_session_token=assumed_role_object['Credentials']['SessionToken'],
                                     service_name=aws_auth['client'],
                                     region_name=aws_auth['region'],
                                     config=Config(retries={'max_attempts': 3})
                                     )
                try:
                    user_response = iam.get_login_profile(UserName=aws_auth['user_name'])
                    user_name = user_response['LoginProfile']['UserName']
                    iam_user_status = 0
                except Exception as e:
                    user_name = "None"
                    iam_user_status = 1

            except Exception as err:
                user_name = "error"
                iam_user_status = 1
                # stderr.write('Could not get user:\n' + str(err))
        # else:
        #     # print('Please use/set [--profile-name] or [--role-name] with [--role-session]')
        #     return False

        stdout.write(json.dumps({'User': str(user_name), "exit_code": str(iam_user_status)}))
        #

    except Exception as e:
        stderr.write('Could not get user:\n' + str(e))


if __name__ == '__main__':
    main()

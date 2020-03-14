#!/bin/bash

#"======================== VARS =========================";
JENKINS_USER="jenkins"
JENKINS_USER_GROUP="jenkins"
JENKINS_UID="666"
JENKINS_GID="666"
JENKINS_SLAVE_HOME="/var/build/jenkins_slave_home"
JENKINS_PACKAGE_NAME="amazon/amazon-ecs-agent:latest"
JENKINS_CONTAINER_NAME="ecs-agent"

AWS_REGION="us-west-2"
AWS_EFS_NAME="jenkins-slave-efs-nonprod"

#"======================== amazon-ecs-agent =============";
rm -rf /etc/ecs && mkdir -p /etc/ecs
cat << 'EOF' >> /etc/ecs/ecs.config
AWS_DEFAULT_REGION=us-west-2
ECS_CLUSTER=jenkins-slave-nonprod
ECS_ENABLE_TASK_IAM_ROLE=true
ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true
ECS_DATADIR=/data
ECS_LOGFILE=/log/ecs-agent.log
ECS_AVAILABLE_LOGGING_DRIVERS=["awslogs","json-file","journald","logentries","splunk","syslog"]
ECS_RESERVED_PORTS=[22, 2375, 2376, 51678, 51679]
ECS_DISABLE_PRIVILEGED=true
ECS_DISABLE_IMAGE_CLEANUP=false
ECS_IMAGE_CLEANUP_INTERVAL=30m
ECS_IMAGE_MINIMUM_CLEANUP_AGE=1h
ECS_NUM_IMAGES_DELETE_PER_CYCLE=5
ECS_IMAGE_PULL_BEHAVIOR=default
ECS_IMAGE_PULL_INACTIVITY_TIMEOUT=1m
ECS_ENABLE_TASK_CPU_MEM_LIMIT=true
ECS_CONTAINER_INSTANCE_PROPAGATE_TAGS_FROM=none
ECS_CONTAINER_INSTANCE_TAGS={"Name": "jenkins-slave-nonprod"}
ECS_ENABLE_UNTRACKED_IMAGE_CLEANUP=false
ECS_EXCLUDE_UNTRACKED_IMAGE=["alpine:latest"]
ECS_DISABLE_DOCKER_HEALTH_CHECK=false
ECS_ENABLE_SPOT_INSTANCE_DRAINING=false
ECS_LOGLEVEL=info
ECS_RESERVED_MEMORY=4096
DOCKER_HOST=unix:///var/run/docker.sock
EOF
# All setting are here: https://github.com/aws/amazon-ecs-agent
# can be used as well, if will allow using S3 by AWS CLI
#aws s3 cp s3://your_bucket_name/ecs.config /etc/ecs/ecs.config

mkdir -p $JENKINS_SLAVE_HOME/{logs,data}
chown -R 1$JENKINS_UID:1$JENKINS_GID $JENKINS_SLAVE_HOME
chmod -R 777 $JENKINS_SLAVE_HOME

setfacl -m user:$JENKINS_USER:rw /var/run/docker.sock
chmod 777 /var/run/docker.sock

cp -rf /usr/bin/docker-init /sbin/docker-init

docker pull amazon/amazon-ecs-agent:latest

if [ "$(docker ps -a | grep -E "$JENKINS_CONTAINER_NAME")" != "" ]; then
  docker rm -f $JENKINS_CONTAINER_NAME
  echo "The [$JENKINS_CONTAINER_NAME] has been deleted...."
fi

mkdir /sys/fs/cgroup/{systemd,freezer,pids,net_cls,perf_event,cpuset,cpu,memory,blkio,devices,hugetlb}/ecs
echo "1" > /sys/fs/cgroup/cpuset/ecs/cpuset.cpus
echo "0" > /sys/fs/cgroup/cpuset/ecs/cpuset.mems

docker run \
  --init \
  --name $JENKINS_CONTAINER_NAME \
  --privileged \
  --detach=true \
  --restart=on-failure:10 \
  -p 127.0.0.1:51678:51678 \
  --volume=/var/run:/var/run \
  --volume="/sys/fs/cgroup:/sys/fs/cgroup" \
  --volume="/var/run/docker.sock:/var/run/docker.sock" \
  --volume=/etc/ecs:/etc/ecs \
  --volume=/sbin:/sbin \
  --volume=/usr/bin:/usr/bin \
  --volume=/lib:/lib \
  --volume=/lib64:/lib64 \
  --volume=/usr/lib:/usr/lib \
  --volume=/usr/lib64:/usr/lib64 \
  --volume=/proc:/host/proc \
  --volume="$JENKINS_SLAVE_HOME/logs:/log:Z" \
  --volume="$JENKINS_SLAVE_HOME/data:/data:Z" \
  --net=host \
  --env-file=/etc/ecs/ecs.config \
  --env ECS_ENABLE_TASK_ENI=true \
  --env ECS_UPDATES_ENABLED=true \
  --env ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION=1h \
  --env ECS_DATADIR=/data \
  --env ECS_ENABLE_TASK_IAM_ROLE=true \
  --env ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true \
  --env ECS_LOGFILE=/log/ecs-agent.log \
  --env ECS_AVAILABLE_LOGGING_DRIVERS='["awslogs","json-file","journald","logentries","splunk","syslog"]' \
  --env ECS_LOGLEVEL=info \
  --env ECS_RESERVED_MEMORY=4096 \
  --env AWS_DEFAULT_REGION=us-west-2 \
  --cap-add=sys_admin \
  --cap-add=net_admin \
  --user "$JENKINS_UID":"$JENKINS_GID" \
  $JENKINS_PACKAGE_NAME
# All setting are here: https://github.com/aws/amazon-ecs-agent

#"====================== AWS EFS =======================";
DEBIAN_FRONTEND=noninteractive apt-get install -y git nfs-common
cd ~ && git clone https://github.com/aws/efs-utils
cd efs-utils && bash ./build-deb.sh
apt-get -y install ./build/amazon-efs-utils*deb

sleep 30
EFS_ID=$(aws efs describe-file-systems --region=$AWS_REGION --output=text --query FileSystems[?Name==\'$AWS_EFS_NAME\'].FileSystemId)
EFS_DNS_NAME="$EFS_ID.efs.$AWS_REGION.amazonaws.com"

echo -e "$EFS_ID:/ $JENKINS_SLAVE_HOME efs defaults,_netdev 0 0" >> /etc/fstab

if [ "$(mount -l | grep -E "amazonaws.com")" != "" ]; then
  echo "AWS EFS already mounted!"
  exit 0
else
  echo "will mount AWS EFS"
  mount -t efs -o tls,ocsp $EFS_ID:/ $JENKINS_SLAVE_HOME
  mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $EFS_DNS_NAME:/ $JENKINS_SLAVE_HOME
fi

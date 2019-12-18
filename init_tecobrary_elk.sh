#! /bin/bash

# Start Message

echo "################################################################################"
echo "######    I'M TECORVIS. NOW I WILL HELP YOU.                              ######"
echo "######           TECOBRARY-ELK TEST ENVIRONMENT DOCKER SETTING &&         ######"
echo "######                                             DO DOCKER COMPOSE UP   ######"
echo "################################################################################"
echo ""

# Variables

LINE_CONTOUR="################################################################################"

TECORVIS_SAY="TECORVIS ###"

ELK_VERSION="7.5.0"

EMPTY=0

JDBC_DRIVER_VERSION=5.1.34
JDBC_DRIVER_DIRECTORY_PATH=./logstash/jdbc_driver
JDBC_DRIVER_FILE_NAME=mysql-connector-java.jar

# JDBC Driver Find And Download

EXIST_DRIVER_INFO=$(ls JDBC_DRIVER_DIRECTORY_PATH| grep "$JDBC_DRIVER_FILE_NAME")

echo ""
echo "$LINE_CONTOUR"
echo ""

echo "$TECORVIS_SAY Check JDBC Driver [${JDBC_DRIVER_DIRECTORY_PATH}/${JDBC_DRIVER_FILE_NAME}] Exists. "
echo ""

if [ "$EXIST_DRIVER_INFO" != ${EMPTY} ]; then
    echo "$TECORVIS_SAY I Found It !"
else
    echo "$TECORVIS_SAY No. We Need To Download !"
    echo "$TECORVIS_SAY Let's Download [${JDBC_DRIVER_FILE_NAME}] !"
    echo ""
    echo "$TECORVIS_SAY Just Wait Few Minutes ... Now I'm Working Hard !"
    echo `wget -c http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${JDBC_DRIVER_VERSION}.zip`
    echo `unzip mysql-connector-java-${JDBC_DRIVER_VERSION}`
    echo `cp ./mysql-connector-java-${JDBC_DRIVER_VERSION}/mysql-connector-java-${JDBC_DRIVER_VERSION}-bin.jar ./logstash/jdbc_driver/${JDBC_DRIVER_FILE_NAME}`
    echo `rm -r mysql-connector-java-${JDBC_DRIVER_VERSION}`
    echo `rm mysql-connector-java-${JDBC_DRIVER_VERSION}.zip`
    if [ "#(ls "${JDBC_DRIVER_DIRECTORY_PATH}" | grep "$JDBC_DRIVER_FILE_NAME")" == ${EMPTY} ]; then
        echo "$TECORVIS_SAY Something Wrong. Please Execute Me Again."
    fi
    echo "$TECORVIS_SAY JDBC Driver [${JDBC_DRIVER_DIRECTORY_PATH}/${JDBC_DRIVER_FILE_NAME}] Download Succeed !"
    echo ""
fi

# Check ELK Images And Remove

ES_IMAGE_INFO=$(docker image ls | grep "tecobrary-elk_tecobrary-es")
KIBANA_IMAGE_INFO=$(docker image ls | grep "tecobrary-elk_tecobrary-kibana")
LOGSTASH_IMAGE_INFO=$(docker image ls | grep "tecobrary-elk_tecobrary-logstash")

echo ""
echo "$LINE_CONTOUR"
echo ""

echo "$TECORVIS_SAY Checking Old [tecobrary-elk_tecobrary-es] Docker Image. Wait Few Minutes..."

if [ ${#ES_IMAGE_INFO} != ${EMPTY} ]; then
    echo "$TECORVIS_SAY We Need To Remove Old [tecobrary-elk_tecobrary-es] Docker Image."
    echo `docker rmi -f tecobrary-elk_tecobrary-es`
else
    echo "$TECORVIS_SAY No Old [tecobrary-elk_tecobrary-es] Docker Image."
fi

echo ""

echo "$TECORVIS_SAY Checking Old [tecobrary-elk_tecobrary-kibana] Docker Image. Wait Few Minutes..."

if [ ${#KIBANA_IMAGE_INFO} != ${EMPTY} ]; then
    echo "$TECORVIS_SAY We Need To Remove Old [tecobrary-elk_tecobrary-kibana] Docker Image."
    echo `docker rmi -f tecobrary-elk_tecobrary-kibana`
else
    echo "$TECORVIS_SAY No Old [tecobrary-elk_tecobrary-kibana] Docker Image."
fi

echo ""

echo "$TECORVIS_SAY Checking Old [tecobrary-elk_tecobrary-logstash] Docker Image. Wait Few Minutes..."

if [ ${#LOGSTASH_IMAGE_INFO} != ${EMPTY} ]; then
    echo "$TECORVIS_SAY We Need To Remove Old [tecobrary-elk_tecobrary-logstash] Docker Image."
    echo `docker rmi -f tecobrary-elk_tecobrary-logstash`
else
    echo "$TECORVIS_SAY No Old [tecobrary-elk_tecobrary-logstash] Docker Image."
fi

echo ""

# Check ELK Running Container Exists, Then Stop And Remove

ES_CONTAINER_RUNNING_INFO=$(docker ps | grep "tecobrary-es")
KIBANA_CONTAINER_RUNNING_INFO=$(docker ps | grep "tecobrary-kibana")
LOGSTASH_CONTAINER_RUNNING_INFO=$(docker ps | grep "tecobrary-logstash")


echo "$TECORVIS_SAY Checking [tecobrary-es] Docker Container Is Running. Wait Few Minutes..."

if [ ${#ES_CONTAINER_RUNNING_INFO} != ${EMPTY} ]; then
    echo "$TECORVIS_SAY We Need To Remove Old [tecobrary-es] Docker Image."
    echo `docker stop tecobrary-es`
    echo `docker rm tecobrary-es`
else
    echo "$TECORVIS_SAY No Old [tecobrary-es] Docker Image."
fi

echo ""

echo "$TECORVIS_SAY Checking [tecobrary-kibana] Docker Container Is Running. Wait Few Minutes..."

if [ ${#KIBANA_CONTAINER_RUNNING_INFO} != ${EMPTY} ]; then
    echo "$TECORVIS_SAY We Need To Remove Old [tecobrary-kibana] Docker Image."
    echo `docker stop tecobrary-kibana`
    echo `docker rm tecobrary-kibana`
else
    echo "$TECORVIS_SAY No Old [tecobrary-kibana] Docker Image."
fi

echo ""

echo "$TECORVIS_SAY Checking [tecobrary-logstash] Docker Container Is Running. Wait Few Minutes..."

if [ ${#LOGSTASH_CONTAINER_RUNNING_INFO} != ${EMPTY} ]; then
    echo "$TECORVIS_SAY We Need To Remove Old [tecobrary-logstash] Docker Image."
    echo `docker stop tecobrary-logstash`
    echo `docker rm tecobrary-logstash`
else
    echo "$TECORVIS_SAY No Old [tecobrary-logstash] Docker Image."
fi

echo ""



# Docker Image Build And Run ELK Containers
echo ""
echo "$TECORVIS_SAY Now Build Docker Image And Run Test Environment Just Wait"
echo `ELK_VERSION=${ELK_VERSION} docker-compose -f ./docker-compose.yml up -d`
echo ""
echo ""
echo "$TECORVIS_SAY Thanks Finished !"
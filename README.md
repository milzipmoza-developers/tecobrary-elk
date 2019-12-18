# tecobrary-elk
테코브러리의 ELK 스택(Elasticsearch, Logstash, Kibana)을 위한 레포지토리입니다.

<br>

# Docker Settings

## ELK Network
<br>

1. 브릿지 네트워크 생성 명령어
```shell script
$ docker network create --driver bridge tecobrary-elk-network
```
tecobrary-elk-network : [브릿지 이름]

<br>

2. 브릿지 네트워크 삭제 명령어
```shell script
$ docker network rm tecobrary-elk-network
```

<br>

# Dockerfile
<br>

## elasticsearch
<br>

1. Docker image 빌드 명령어
```shell script
$ docker build -t tecobrary-es .
```
<br>

2. Docker image run 명령어

```shell script
$ docker run -p 9200:9200 -p 9300:9300 -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
--network tecobrary-elk-network --name tecobrary-es tecobrary-es 
```

## kibana
<br>

1. Docker image 빌드 명령어
```shell script
$ docker build -t tecobrary-kibana .
```
<br>

2. Docker image run 명령어

```shell script
$ docker run -p 5601:5601 --network tecobrary-elk-network --name tecobrary-kibana tecobrary-kibana
```

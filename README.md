# tecobrary-elk
테코브러리의 ELK 스택(Elasticsearch, Logstash, Kibana)을 위한 레포지토리입니다.

<br>

# Shell Script 사용법
<br>

1. 도커 기존 컨테이너, 이미지 삭제 후 이미지 빌드 및 컨테이너 실행
```shell script
$ ./init_tecobrary_elk.sh
```

<br>

# docker-compose 사용법
<br>

1. 실행중인 docker container 중지
```shell script
$ docker stop tecobrary-es tecobrary-kibana tecobrary-logstash 
```
<br>

2. 기존 docker container 삭제
```shell script
$ docker rm tecobrary-es tecobrary-kibana tecobrary-logstash 
```

<br>

3. 중지된 docker image 삭제
```shell script
$ docker rmi -f tecobrary-elk_tecobrary-es tecobrary-elk_tecobrary-kibana tecobrary-elk_tecobrary-logstash
```
<br>

3. docker-compose 실행 명령어
```shell script
$ ELK_VERSION="7.5.0" docker-compose up -d
```
<br>

4. docker-compose 종료 명령어
```shell script
$ docker-compose down
```
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

## logstash
<br>

1. Docker image 빌드 명령어
```shell script
$ docker build -t tecobrary-logstash .
```

<br>

2. Docker image run 명령어

```shell script
$ docker run -p 9600:9600 -p 5000:5000 -e "LS_JAVA_OPTS=-Xms256m -Xmx256m" \
--network tecobrary-elk-network --name tecobrary-logstash tecobrary-logstash
```

ARG ELK_VERSION="7.5.0"

# https://github.com/elastic/logstash-docker
FROM docker.elastic.co/logstash/logstash:${ELK_VERSION}

COPY ./config/logstash.yml /usr/share/logstash/config/logstash.yml
COPY ./pipeline /usr/share/logstash/pipeline

# Add your logstash plugins setup here
# Example: RUN logstash-plugin install logstash-filter-json

# Copy JDBC DRIVER "mysql-connector-java.jar"
COPY ./jdbc_driver/mysql-connector-java.jar /usr/share/logstash/logstash-core/lib/jars/mysql-connector-java.jar
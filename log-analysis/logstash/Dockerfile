FROM java
RUN apk add --update wget ca-certificates
RUN apk add --update bash
RUN wget -nv "https://download.elastic.co/logstash/logstash/logstash-2.1.0.tar.gz" && \
    tar xzf logstash-2.1.0.tar.gz && \
    rm logstash-2.1.0.tar.gz
COPY logstash.conf logstash.conf
VOLUME /log
CMD logstash-2.1.0/bin/logstash -f logstash.conf

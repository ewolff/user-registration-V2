FROM java
RUN apk add --update wget ca-certificates
RUN apk add --update sudo
RUN adduser -D elasticsearch
RUN cd /home/elasticsearch && \
    sudo -u elasticsearch wget -nv "https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.1.0/elasticsearch-2.1.0.tar.gz" && \
    sudo -u elasticsearch tar xzf elasticsearch-2.1.0.tar.gz && \
    rm elasticsearch-2.1.0.tar.gz
CMD sudo -u elasticsearch /home/elasticsearch/elasticsearch-2.1.0/bin/elasticsearch -Des.network.host=_eth0_
EXPOSE 9200
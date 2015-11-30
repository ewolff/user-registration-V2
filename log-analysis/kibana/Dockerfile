FROM alpine:3.2
RUN apk add --update wget ca-certificates
RUN apk add --update nodejs
RUN wget -nv https://download.elastic.co/kibana/kibana/kibana-4.3.0-linux-x64.tar.gz && \
    tar xzf kibana-4.3.0-linux-x64.tar.gz && \
    rm kibana-4.3.0-linux-x64.tar.gz && \
    rm -rf kibana-4.3.0-linux-x64/node
COPY kibana.yml /kibana-4.3.0-linux-x64/config
CMD kibana-4.3.0-linux-x64/bin/kibana
EXPOSE 5601
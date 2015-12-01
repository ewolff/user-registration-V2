FROM ubuntu:15.04
RUN apt-get update ; apt-get dist-upgrade -y -qq 
RUN apt-get install -y -qq wget
RUN apt-get install -y -qq graphite-carbon
ADD carbon.conf /etc/carbon/carbon.conf
VOLUME /var/lib/graphite/whisper/
CMD carbon-cache start --config=/etc/carbon/carbon.conf --logdir=/var/log/carbon/ --debug
EXPOSE 2003
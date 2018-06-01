FROM ubuntu:16.04
RUN apt-get update ; apt-get dist-upgrade -y -qq 
RUN apt-get install -y -qq graphite-web
COPY local_settings.py /etc/graphite
RUN graphite-manage syncdb --noinput
CMD graphite-manage runserver 0.0.0.0:80 
EXPOSE 80

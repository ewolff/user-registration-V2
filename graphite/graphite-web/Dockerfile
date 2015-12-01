FROM ubuntu-update
RUN apt-get install -y -qq graphite-web
COPY local_settings.py /etc/graphite
RUN graphite-manage syncdb --noinput
CMD graphite-manage runserver 0.0.0.0:80 
EXPOSE 80

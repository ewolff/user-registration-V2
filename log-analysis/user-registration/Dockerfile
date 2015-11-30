FROM ewolff/docker-java
VOLUME /log
COPY user-registration-application-0.0.1-SNAPSHOT.war user-registration-application-0.0.1-SNAPSHOT.war
CMD /usr/bin/java -Dlogging.path=/log/ -jar user-registration-application-0.0.1-SNAPSHOT.war
EXPOSE 8080
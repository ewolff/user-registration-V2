FROM ewolff/docker-java
COPY user-registration-application-0.0.1-SNAPSHOT.war user-registration-application-0.0.1-SNAPSHOT.war
CMD /usr/bin/java -Dgraphite.enabled=true -Dgraphite.host=carbon -Dgraphite.port=2003 -jar user-registration-application-0.0.1-SNAPSHOT.war
EXPOSE 8080
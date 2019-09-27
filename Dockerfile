FROM alpine
RUN apk add --no-cache openjdk11-jre dumb-init
COPY user-registration-application/target/user-registration-application-0.0.1-SNAPSHOT.war /user-registration-application.war
EXPOSE 8080
CMD ["/usr/bin/dumb-init", "/usr/bin/java", "-jar", "/user-registration-application.war"]

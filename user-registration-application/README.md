The Application
==========

[German / Deutsch](LIESMICH.md)

The application itself just contains functionality to register users. Users are stored in an In-Memory-Database.

- You can run the application using `./mvnw spring-boot:run` (macOS, Linux) or `./mvnw.cmd spring-boot:run` (Windows)
- ...or you can afterwards run the WAR using `java -jar user-registration-application-0.0.1-SNAPSHOT.war`
- ...or you can deploy the WAR into a Servlet 3.0 compatible container such as Tomcat

The application uses Spring Boot. For the web interface Thymeleafe templates are used.

The application can only be built if `mvn install` was run at least
once in the directory `user-registration-V2` to copy the parent POM
into the local Maven repo.
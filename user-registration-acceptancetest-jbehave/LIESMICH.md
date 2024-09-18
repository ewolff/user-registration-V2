JBehave Akzeptanztests
================

Hinweis: Dies funktioniert derzeit nur mit Java 8. Du kannst
[SDKMAN!](https://sdkman.io/) verwenden, um mehrere Versionen von Java
zu installieren. `sdk list java` zeigt installierbare Versionen von
Java, `sdk install java` kannst Du eine installieren , und dann mit
`sdk use java 8.0.382-tem` die Version in der aktuellen Shell nutzen.

Dieses Projekt enthält JBehave-Akzeptanztest. Im Verzeichnis
`src/main/resource` finden sich die Stories, die Teil des Tests sind.

Diese Tests sind in Deutsch. Die englischen Tests finden sich unter
[user-registration-acceptancetest-jbehave-english](../user-registration-acceptancetest-jbehave-english).

Zum ausführen:

- Führe `./mvnw -pl user-registration-application -am install` im
  Verzeichnis `user-registration-V2` aus.
- Führe `./mvnw integration-test` (macOS, Linux) oder `./mvnw.cmd integration-test` (Windows) in diesem Unterverzeichnis aus.
- Die Ergebnisse der Tests finden sich im Verzeichnis `target/jbehave`.

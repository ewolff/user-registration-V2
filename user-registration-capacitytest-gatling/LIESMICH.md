Gatling Kapazitätstests
================

Dieses Projekt enthält Kapazitätstest mit Gatling. Der Code für den
Test findet sich in `src/test/scala` .

Zum ausführen:

- Führe `./mvnw -pl user-registration-application -am install` im
  Verzeichnis `user-registration-V2` aus.
- Führe  `./mvnw test` (macOS, Linux) or `./mvnw.cmd test` (Windows) in diesem Unterverzeichnis aus.
- Die Ergebniss finden sich im Unterverzeichnis `target/gatling/results`

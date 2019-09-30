Gatling Capacity Tests
================

[German / Deutsch](LIESMICH.md)

This project contains capacity tests with Gatling. Look at
`src/test/scala` for the test code.

To run:

- Execute `./mvnw -pl user-registration-application -am install` in
  the directory `user-registration-V2`.
- Execute  `./mvnw test` (macOS, Linux) or `./mvnw.cmd test` (Windows) in this subdir
- Find the results in the subdir `target/gatling/results`

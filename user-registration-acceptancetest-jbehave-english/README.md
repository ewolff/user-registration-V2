JBehave Acceptance Tests
================

[German / Deutsch](LIESMICH.md)

Note: This currently only works with Java 8. You can user
[SDKMAN!](https://sdkman.io/) to have multiple versions of java
installed, find a version with `sdk list java`, install one with `sdk
install java`  and select one with `sdk use java 8.0.382-tem` in the
current shell.

This project contains acceptance tests with JBehave. Look at `src/main/resource` for the stories that are part of this test.

Note: These tests are in English. Refer to
[user-registration-acceptancetest-jbehave](../user-registration-acceptancetest-jbehave) for a German
version.


To run:

- Execute `./mvnw -pl user-registration-application -am install` in
  the directory `user-registration-V2`.
- Execute `./mvnw integration-test` (macOS, Linux) or `./mvnw.cmd integration-test` (Windows) in this subdir
- Find the results in the subdir `target/jbehave`

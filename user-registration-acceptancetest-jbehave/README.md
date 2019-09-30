JBehave Acceptance Tests
================

[German / Deutsch](LIESMICH.md)

This project contains acceptance tests with JBehave. Look at
`src/main/resource` for the stories that are part of this test.

Note: These tests are in German. Refer to
[user-registration-acceptancetest-jbehave-english](../user-registration-acceptancetest-jbehave-english) for an English
version.

To run:

- Execute `./mvnw -pl user-registration-application -am install` in
  the directory `user-registration-V2`.
- Execute `./mvnw integration-test` (macOS, Linux) or `./mvnw.cmd integration-test` (Windows) in this subdir
- Find the results in the subdir `target/jbehave`

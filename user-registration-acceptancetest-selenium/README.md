Selenium Acceptance Tests
================

[German / Deutsch](LIESMICH.md)

This project contains acceptance tests with Selenium. Look at
`src/test/java` for the source code of the tests.

To run:

- Execute `./mvnw -pl user-registration-application -am install` in
  the directory `user-registration-V2`.
- Execute `./mvnw test` (macOS, Linux) or `./mvnw.cmd test` (Windows)
in this subdir

The directory `Selenium-IDE-V3` contains tests for the current version
of the [Selenium IDE](https://www.seleniumhq.org/projects/ide/). The
directory `Selenium` contains tests for the old version of the
Selenium IDE.

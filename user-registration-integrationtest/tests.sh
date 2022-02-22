#!/bin/sh
CWD=$(dirname $0)
source ${CWD}/spec.sh

: ${endpoint:=http://localhost:8080}

echo $endpoint

before_all() {
  echo "waiting for service to be available"
  for _ in $(seq 1 180)
  do
    sleep 0.3
    curl -sm 0.1 ${endpoint} && break
  done
  assert_eq $? 0
}

it_returns_error_when_user_does_not_exist() {
  assert_match "$(curl ${endpoint}/usersearch_en?email=foo%40bar.baz)" "No user found with email"
}

it_creates_user_without_returning_an_error() {
  assert_true "curl --fail -XPOST ${endpoint}/user_en?firstname=foo&name=bar&email=foo%40bar.baz"
}

it_returns_existing_user_when_searched() {
  assert_nmatch "$(curl ${endpoint}/usersearch_en?email=foo%40bar.baz)" "No user found with email"
}

it_deletes_user_without_returning_an_error() {
  assert_true "curl --fail -XPOST ${endpoint}/userdelete_en?email=foo%40bar.baz"
}

it_returns_error_when_user_does_not_exist_anymore() {
  assert_match "$(curl ${endpoint}/usersearch_en?email=foo%40bar.baz)" "No user found with email"
}

run_tests test-user-registration-application

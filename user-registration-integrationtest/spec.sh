# Copyright (C) 2015-2016 innoQ Deutschland GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

# This is a mini shell test framework that outputs the test like go test does
# For usage see files tests.sh and failing-tests.sh and execute them to see
# spec.sh in action
# 
#  - usage:                    this script should not be called directly -- for usage see https://github.com/kesselborn/spec.sh#usage ... see env vars below for per-call options
#
# options that can be set via environmnet variables:
#
#  - TESTS="<tests>":          (ext. regexp) if you just want to execute some specific tests, set the TESTS env var to an [_extended_ regexp](https://www.gnu.org/software/sed/manual/html_node/Extended-regexps.html):
#
#        # execute tests that match exactly "it_should_match_string" or match the substring "execute_external_tests"
#        TESTS="(^it_should_match_string$|execute_external_tests)" ./tests.sh
#
#        # execute all tests that contain the word "string" in their name
#        TESTS="string" ./tests.sh
#
#  - INCLUDES="<files>":       (ext. regexp) if you include several test files but temporarily only want to execute tests from one (or more) specific files (works the same as TESTS)
#
#  - VERBOSE=1:                usually, test output is logged to a temporary file and only printed to stdout if an error occurred. If you want to have verbose output to stdout, set VERBOSE:
#
#        VERBOSE=1 ./tests.sh
#
#  - FAIL_FAST=1:              set fail fast to exit immediately after the first test failed:
#
#        FAIL_FAST=1 ./tests.sh
#
#  - NO_ANSI_COLOR=1:          don't add ansi color codes to output
#
#        NO_ANSI_COLOR=1 ./tests.sh
#
#  - RERUN_FAILED_FROM=<file>: run all tests which failed in the provided log file
#
#       ./tests.sh > log1
#
#       # rerun all tests that failed (don't redirect into the same log file -- this will rerun all tests)
#       RERUN_FAILED_FROM=log1 ./tests.sh > log2
#
#  - SHARD:                    runs only every nth test by using mod + offset logic (e.g. SHARD=2+0 ./tests.sh & SHARD=2+1 ./tests.sh)
#
#        SHARD=3+0 ./tests.sh &   \
#          SHARD=3+1 ./tests.sh & \
#          SHARD=3+2 ./tests.sh & \

$(return >/dev/null 2>&1)
test $? -eq 0 || printf "$(cat $0 | grep '^#  - ' | sed 's/^#  - \([^:][^:]*\):/\\033[1;38;40m\1\\033[m/g')\n"

test ! -t || IS_TTY=true                   # omit ansi colors if we don't output to a tty (unreliable)
test -z "$NO_ANSI_COLOR" || unset IS_TTY   # force omit ansi colors
set -o pipefail 2>/dev/null || true        # don't ignore errors that happen in a pipeline
set +o posix    2>/dev/null || true        # switch off strict posix mode as it will cause a dead lock

failed_tests_cnt=0

# call SKIP_TEST for tests you want to ignore temporarily ... optionally pass in a description
SKIP_TEST() {
  (set +x; test -n "$1" && printf "skipping test: ${1}\n")
  exit 222
}


# assert_eq "<got>" "<expected>" ["<description>"]
assert_eq() {
  local description=$3

  (set +x
    local description="${description}${description:+ (}'${1}' $(test -n "${__SPEC_SH_NEGATE}" && echo "!=" || echo "==") '${2}'${description:+)}"
    if [ "${1}" $(test -n "${__SPEC_SH_NEGATE}" && echo "==" || echo "!=") "${2}" ]; then
      printf "${IS_TTY:+\033[1;37;41m}failed expectation:${IS_TTY:+\033[m} ${IS_TTY:+\033[1;38;40m}${description} ${IS_TTY:+\033[m}\n"
      printf "######################################## FAILED TEST: $(echo ${description})\n"
      __spec_sh_execute_defers
      exit 1
    else
      printf "######################################## PASSED TEST: %s\n" "$(echo ${description})"
    fi
  ) || exit 1
}

# assert_neq "<got>" "<expected>" ["<description>"]
assert_neq() {
  __SPEC_SH_NEGATE=1 assert_eq "$@"
}

# assert_true "<command that should succeed>" ["<description>"]
assert_true() {
  $1
  assert_eq $? 0 "${2:-expecting command '$1' to succeed}"
}

# assert_true "<command that should succeed>" ["<description>"]
assert_false() {
  __SPEC_SH_NEGATE=1 assert_true "$@"
}

# assert_match matches the first argument against an _extended_ regular expression, i.e.:
# assert_match "foooobar" "fo{4}bar"
assert_match() {
  (set +o pipefail; printf "%s" "$1" | grep -E -m1 -o "$2" | head -n1 | grep -E "$2")
  assert_eq $? 0 "checking '$1' to match /$2/"
}

# assert_nmatch returns true, if a regexp does not match
# assert_match "foooobar" "xxxxx"
assert_nmatch() {
  __SPEC_SH_NEGATE=1 assert_match "$@"
}


# defer will be executed whenever your test finishes or fails in the middle
defer() {
  __SPEC_SH_DEFERRED_CALLS="$*; ${__SPEC_SH_DEFERRED_CALLS}"
}

# use 'include <file>' to include a file with test functions
include() {
  if echo $1 | grep -E "${INCLUDES:-.*}" &>/dev/null
  then
    __SPEC_SH_INCLUDES="${__SPEC_SH_INCLUDES} $1"
  fi
  source $1
}

# Call run tests at the end of your test file. The name of the testsuite will either
# be the name of the test script or the parameter you pass to 'run_tests'
run_tests() {
  if grep -Eho "(^it_[a-zA-Z_0-9]*|^before_all|^after_all)" $0 ${__SPEC_SH_INCLUDES}|sort|uniq -c|grep -v " .*1"; then echo "duplicate test names forbidden"; exit; fi

  local functions=$(grep -Eho "(^it_[a-zA-Z_0-9]*|^before_all|^after_all)" $0 ${__SPEC_SH_INCLUDES})
  test -z "${RERUN_FAILED_FROM}" || TESTS="$(echo $(grep -- "^--- FAIL:" ${RERUN_FAILED_FROM} | cut -f3 -d" ") | tr " " "|")"
  test -z "${SHARD}" || { local shard_mod="$(echo "${SHARD}" | cut -f1 -d+)"; local shard_offset="$(echo "${SHARD}" | cut -f2 -d+)"; }

  local timer=$(__spec_sh_start_timer total_duration)
  local cnt=0
  for f in $(printf "${functions}" | grep -o "before_all") \
           $(printf "${functions}" | grep "^it_" | grep -E "${TESTS:-.}") \
           $(printf "${functions}" | grep -o "after_all")
  do
    local cnt=$(( $cnt + 1 ))
    test -z "${SHARD}" || { printf "${f}" | grep "^it_" >/dev/null && test $(( (${cnt} + ${shard_offset}) % ${shard_mod} )) -ne 0 && printf "skipping $f due to sharding settings\n" && continue; }
    __spec_sh_run_test $f
  done
  local duration=$(__spec_sh_stop_timer ${timer})

  if [ ${failed_tests_cnt} -eq 0 ]; then
    (export LC_ALL=C; printf "PASS\nok	${1:-$(basename $0|sed 's/\.sh$//g')}	%.3fs\n" ${duration})
  else
    (export LC_ALL=C; printf "FAIL\nexit status %d\nFAIL	${1:-$(basename $0|sed 's/\.sh$//g')}	%.3fs\n" ${failed_tests_cnt} ${duration})
  fi

  exit ${failed_tests_cnt}
}


######### "private" functions

__spec_sh_execute_defers() {
  test -z "${__SPEC_SH_DEFERRED_CALLS}" && return
  local commands=$(echo "${__SPEC_SH_DEFERRED_CALLS}" | tr -s ';')
  local file=$(mktemp /tmp/.spec.sh.deferred_calls.XXXXXX)

  unset __SPEC_SH_DEFERRED_CALLS
  printf -- "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% executing defer commands: 'eval \"${commands}\" &> ${file}'\n"
  test -n "${commands}" && eval "${commands}" &> ${file} || printf "defer errored (defer errors are ignored in test error count):\n$(cat ${file})\n"
  rm ${file}
}

# timer function compatible with busybox shell: call in conjunction with 'stop timer':
# timer=$(__spec_sh_start_timer <timer-name>)
# <commands>
# duration=$(__spec_sh_stop_timer ${timer})
__spec_sh_start_timer() {
  local file=$(mktemp /tmp/.spec.sh.timerfifo.${1:-noname}.XXXXXX)
  (mkfifo ${file}.sync; time -p cat ${file}.sync) 2>&1 | grep real | sed 's/real *//' > ${file} &
  echo ${file}
}

__spec_sh_stop_timer() {
  local file=$1
  printf "" > ${file}.sync
  local duration=$(cat ${file})
  rm ${file}.sync ${file}
  echo ${duration:-0.0}
}

# runs a test and creates appropiate output
__spec_sh_run_test() {
  local function=$1
  local log=$(mktemp)

  local timer=$(__spec_sh_start_timer $1)
  printf "=== RUN ${function}\n"
  test "${VERBOSE}" = "1" && ( set -x; ${function}; res=$?; set +x; __spec_sh_execute_defers; return $res ) 2>&1 | sed 's/^/    /g' |  tee -a ${log} \
                          || ( set -x; ${function}; res=$?; set +x; __spec_sh_execute_defers; return $res ) 2>&1 | sed 's/^/    /g' >>        ${log}
  local result=$?
  local duration=$(__spec_sh_stop_timer ${timer})

  if [ ${result} -eq 0 ]; then
    (export LC_ALL=C; printf -- "--- PASS: %s (%.2fs)\n" ${function} ${duration:0})
  elif [ ${result} -eq 222 ]; then
    cat ${log}|grep " *skipping test:"
    (export LC_ALL=C; printf -- "--- SKIP: %s (%.2fs)\n" ${function} ${duration:0})
  else
    test "${VERBOSE}" = "1" || cat ${log}
    printf "\terror code: %d\n\terror occured in ${IS_TTY:+\033[1;38;40m}%s${IS_TTY:+\033[m}\n" ${result} "$(grep -Hon "${function}" $0 ${__SPEC_SH_INCLUDES})"
    let "failed_tests_cnt++"
    (export LC_ALL=C; printf -- "--- FAIL: %s (%.2fs)\n" ${function} ${duration:0})
    test "${function}" = "before_all" -o "$FAIL_FAST" = "1" && { after_all 2>/dev/null; exit 1; }
  fi
  rm ${log}
}

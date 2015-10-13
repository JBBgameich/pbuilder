#!/bin/bash
# testsuite for testlib

TD="$(dirname "$0")"
if [ -n "$PBUILDER_CHECKOUT" ]; then
    . "$TD/testlib.sh"
    . "$PBUILDER_CHECKOUT/pbuilder-modules"
else
    . "$TD/testlib.sh"
    . "$PBUILDER_TEST_PKGLIBDIR/pbuilder-modules"
fi

test_success() {
    exit 0
}

test_fail() {
    exit 1
}

test_options() {
    echo "$@"
    exit 1
}

test_output() {
    echo "$@"
}

expect_success test_success
expect_fail test_fail
expect_fail test_options "hello world"
expect_output "foo bar" test_output "foo" "bar"
testlib_summary

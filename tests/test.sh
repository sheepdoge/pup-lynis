#!/bin/bash

set -e

test::check_syntax() {
  ansible-playbook playbook.yml -i 'localhost' --syntax-check
}

test::run_ansible() {
  ansible-playbook playbook.yml -i 'localhost'
}

test::assert_output() {
  echo 'skipping'
}

test::check_syntax
test::run_ansible
test::assert_output

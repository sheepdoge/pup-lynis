#!/bin/bash

set -e

test::check_syntax() {
  ansible-playbook playbook.yml -i 'localhost' --syntax-check
}

test::run_ansible() {
  ansible-playbook playbook.yml -i 'localhost'
}

test::_lynis_installed() {
  apt list --installed | grep -q lynis
}

test::_proper_configuration_file() {
  stat /etc/lynis/test.prf >/dev/null 2>&1
  grep -q NETW-2704 /etc/lynis/test.prf
}

test::_created_crontab() {
  crontab -l | grep -q lynis
}

# NOTE! We assume that `lynis audit system` will fail. This assumption feels
# fairly safe to me, because we haven't done any configuration to make lynis
# pass. However, if we find it is flakey over time, we may want to make changes
# to ensure `lynis` fails.
test::_simulate_cron_job() {
  lynis audit system --cronjob --profile /etc/lynis/test.prf || \
  more /root/.bashrc | grep -q "echo WARNING: lynis system audit failed" || \
  echo "echo WARNING: lynis system audit failed" >> /root/.bashrc
}

test::_only_write_lynis_warning_once() {
  test::_simulate_cron_job
  if [ "$(grep -c lynis /root/.bashrc)" -ne 1 ]
  then
    tail /root/.bashrc
    exit 1
  fi
}

test::assert_output() {
  test::_lynis_installed
  test::_proper_configuration_file
  test::_created_crontab
  test::_only_write_lynis_warning_once
  test::_only_write_lynis_warning_once
}

test::check_syntax
test::run_ansible
test::assert_output

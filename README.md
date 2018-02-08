# pup-lynis

[sheepdoge](https://github.com/mattjmcnaughton/sheepdoge) pup for running
automated system audits using `lynis`. It runs a full lynis audit on an
automated schedule, and sends a notification if there's an issue.

## Variables

`pup-lynis` expects you to define the following variables:
- `pup_lynis_main_lynis_ignored_warnings`: A list of lynis warnings which you
  would like to ignore (i.e. don't alert me if these warnings are raised).
- `pup_lynis_main_lynis_profile_name`: The name of the custom lynis profile.
- `pup_lynis_main_reporting_file`: The file into which the cronjob
  will add an `echo` statement if the lynis check fails.
  This file should be your login file (i.e. ~/.bashrc, ~/.zshrc, etc.).

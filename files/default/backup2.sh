#!/bin/bash

#Are we running on slave?
OUTPUT=$(mysql -u root -pmaster -e "select count(1) from information_schema.global_status WHERE variable_name = 'Slave_running' AND variable_value = 'ON';" | head -2 | tail -1``)

if [ -n "$OUTPUT" ]; then #get a syntax error when $OUTPUT is empty
  if [ $OUTPUT == "1" ]; then  #Back it up!
    /opt/chef/embedded/bin/backup perform --trigger rotation --root-path /var/optoro/backup
  fi
fi

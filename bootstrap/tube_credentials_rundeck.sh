#!/bin/bash

salt -I 'tube_salt:enabled:True' pillar.get tube:secrets:rundeck:rundeck_admin_user
salt -I 'tube_salt:enabled:True' pillar.get tube:secrets:rundeck:rundeck_admin_unencrypted_password

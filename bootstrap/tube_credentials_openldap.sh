#!/bin/bash

salt -I 'tube_salt:enabled:True' pillar.get tube:secrets:openldap:ldap_rootdn
salt -I 'tube_salt:enabled:True' pillar.get tube:secrets:openldap:ldap_unencrypted_rootpw

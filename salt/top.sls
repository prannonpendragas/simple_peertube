base:
  'tube_dns:enabled:True':
    - match: pillar
    - tube_dns
  'compunaut_openldap:enabled:True':
    - match: pillar
    - compunaut_openldap
  'not I@compunaut_openldap:enabled:True':
    - match: compound
    - compunaut_openldap
  '*':
    - tube_chronyd
    - tube_default
    - tube_iptables

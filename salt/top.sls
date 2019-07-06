base:
  'tube_pki:enabled:True':
    - match: pillar
    - tube_pki.deploy
  'tube_dns:enabled:True':
    - match: pillar
    - tube_dns
  'tube_postgresql:enabled:True':
    - match: pillar
    - tube_postgresql
  'tube_openldap:enabled:True':
    - match: pillar
    - tube_openldap
  'not I@tube_openldap:enabled:True':
    - match: compound
    - tube_openldap
  '*':
    - tube_chronyd
    - tube_default
    - tube_iptables
    - tube_sssd

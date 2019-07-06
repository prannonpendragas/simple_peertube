base:
  '*master*':
    - tube_openldap
    - tube_salt
  '*':
    - tube_chronyd
    - tube_default
    - tube_dns
    - tube_iptables
    - tube_openldap.client

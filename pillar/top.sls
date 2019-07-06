base:
  '*data*':
    - tube_postgresql
    - tube_redis
  '*master*':
    - tube_openldap
    - tube_rundeck
    - tube_salt
  '*':
    - tube_chronyd
    - tube_default
    - tube_dns
    - tube_iptables
    - tube_openldap.client
    - tube_pki
    - tube_sssd

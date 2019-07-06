base:
  '*master*':
    - tube_salt
  '*':
    - tube_chronyd
    - tube_default
    - tube_dns
    - tube_iptables

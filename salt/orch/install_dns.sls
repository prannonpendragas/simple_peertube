install_dns_server:
  salt.state:
    - tgt: 'tube_dns:server:enabled:True'
    - tgt_type: pillar
    - sls:
      - tube_dns

install_dns_clients:
  salt.state:
    - tgt: '*'
    - sls:
      - tube_dns

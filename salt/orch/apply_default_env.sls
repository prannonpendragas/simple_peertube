apply_default_environment:
  salt.state:
    - tgt: '*'
    - sls:
      - tube_default
      - tube_iptables

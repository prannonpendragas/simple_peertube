install_postgresql:
  salt.state:
    - tgt: 'tube_postgresql:enabled:True'
    - tgt_type: pillar
    - sls:
      - tube_postgresql

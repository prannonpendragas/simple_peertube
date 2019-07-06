install_redis:
  salt.state:
    - tgt: 'tube_redis:enabled:True'
    - tgt_type: pillar
    - sls:
      - tube_redis

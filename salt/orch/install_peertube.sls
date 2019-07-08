install_peertube:
  salt.state:
    - tgt: 'tube_peertube:enabled:True'
    - tgt_type: pillar
    - sls:
      - tube_peertube
      - letsencrypt

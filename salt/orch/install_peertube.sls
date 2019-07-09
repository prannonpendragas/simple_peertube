install_peertube:
  salt.state:
    - tgt: 'tube_peertube:enabled:True'
    - tgt_type: pillar
    - sls:
      - tube_postfix
      - tube_peertube
      - letsencrypt

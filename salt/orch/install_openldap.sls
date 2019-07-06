install_openldap:
  salt.state:
    - tgt: 'tube_openldap:enabled:True'
    - tgt_type: pillar
    - sls:
      - tube_openldap

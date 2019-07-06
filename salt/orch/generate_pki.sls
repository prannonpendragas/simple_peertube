mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'
    - batch: 6

wait_to_generate_tube_pki:
  salt.function:
    - name: cmd.run
    - tgt: 'tube_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - sleep 30

generate_tube_pki:
  salt.state:
    - tgt: 'tube_salt:enabled:True'
    - tgt_type: pillar
    - sls:
      - tube_pki.ssh
      - tube_pki.ca
      - tube_pki.crt

deploy_tube_pki:
  salt.state:
    - tgt: 'tube_pki:enabled:True'
    - tgt_type: pillar
    - batch: 6
    - sls:
      - tube_default.users
      - tube_pki.deploy

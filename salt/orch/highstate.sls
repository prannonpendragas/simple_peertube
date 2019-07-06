run_highstate_on_salt_master:
  salt.state:
    - tgt: 'tube_salt:enabled:True'
    - tgt_type: pillar
    - highstate: True

run_highstate_on_remaining_nodes:
  salt.state:
    - tgt: 'not I@tube_salt:enabled:True'
    - tgt_type: compound
    - batch: 4
    - batch_wait: 15
    - highstate: True

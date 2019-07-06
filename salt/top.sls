base:
  'tube_dns:enabled:True':
    - match: pillar
    - tube_dns
  '*':
    - tube_chronyd
    - tube_default

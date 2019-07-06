include:
  - iptables

restart_salt_minion_after_rules:
  cmd.run:
    - name: 'salt-call service.restart salt-minion'
    - runas: root
    - bg: true
    - onchanges:
      - sls: iptables

/etc/salt/minion.d/mine.conf:
  file.managed:
    - source: salt://tube_salt/config/minion.d_mine.conf
    - user: root
    - group: root
    - mode: 0644

/etc/salt/minion.d/minion_tuning.conf:
  file.managed:
    - source: salt://tube_salt/config/minion_tuning.conf
    - user: root
    - group: root
    - mode: 0644

restart_salt_minion:
  cmd.run:
    - name: 'salt-call service.restart salt-minion'
    - runas: root
    - bg: true
    - onchanges:
      - file: /etc/salt/minion.d/mine.conf
      - file: /etc/salt/minion.d/minion_tuning.conf

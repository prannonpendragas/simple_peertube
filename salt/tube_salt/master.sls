/etc/salt/master.d/fileserver_backends.conf:
  file.managed:
    - source: salt://tube_salt/config/fileserver_backends.conf
    - user: root
    - group: root
    - mode: 0644

/etc/salt/master.d/gitfs.conf:
  file.managed:
    - source: salt://tube_salt/config/gitfs.conf
    - user: root
    - group: root
    - mode: 0644

/etc/salt/master.d/master_tuning.conf:
  file.managed:
    - source: salt://tube_salt/config/master_tuning.conf
    - user: root
    - group: root
    - mode: 0644

/etc/salt/master.d/mine.conf:
  file.managed:
    - source: salt://tube_salt/config/master.d_mine.conf
    - user: root
    - group: root
    - mode: 0644

restart_salt_master:
  cmd.run:
    - name: 'salt-call service.restart salt-master'
    - runas: root
    - bg: true
    - onchanges:
      - file: /etc/salt/master.d/fileserver_backends.conf
      - file: /etc/salt/master.d/gitfs.conf
      - file: /etc/salt/master.d/master_tuning.conf
      - file: /etc/salt/master.d/mine.conf

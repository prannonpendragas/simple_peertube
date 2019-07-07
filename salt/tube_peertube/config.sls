/var/www/peertube/config/production.yaml:
  file.managed:
    - source: salt://tube_peertube/config/production.yaml
    - template: jinja
    - makedirs: True
    - user: peertube
    - group: peertube
    - file_mode: 0640
    - dir_mode: 0750

/etc/sysctl.d/30-peertube-tcp.conf:
  file.managed:
    - source: salt://tube_peertube/config/30-peertube-tcp.conf
    - makedirs: True
    - user: root
    - group: root
    - dir_mode: 0755
    - file_mode: 0644

'sysctl -p /etc/sysctl.d/30-peertube-tcp.conf':
  cmd.run:
    - runas: root

/etc/systemd/system/peertube.service:
  file.managed:
    - source: salt://tube_peertube/config/peertube.service
    - makedirs: True
    - user: root
    - group: root
    - dir_mode: 0755
    - file_mode: 0644

'systemctl daemon-reload':
  cmd.run:
    - runas: root

'sysctl net.ipv6.conf.all.disable_ipv6=1':
  cmd.run:
    - runas: root

/etc/sysctl.d/11-disable_ipv6.conf:
  file.managed:
    - contents: "net.ipv6.conf.all.disable_ipv6=1"
    - user: root
    - group: root
    - mode: 0644

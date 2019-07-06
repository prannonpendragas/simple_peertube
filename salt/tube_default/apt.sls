/etc/apt/apt.conf.d/99force-ipv4:
  file.managed:
    - contents: 'Acquire::ForceIPv4 "true";'
    - user: root
    - group: root
    - mode: 0644

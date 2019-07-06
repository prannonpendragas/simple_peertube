/etc/sudoers:
  file.managed:
    - source: salt://tube_default/sudo/sudoers
    - user: root
    - group: root
    - mode: 0440

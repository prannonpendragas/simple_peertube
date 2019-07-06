/root/.bashrc:
  file.managed:
    - source: salt://tube_default/bash/bashrc
    - user: root
    - group: root
    - mode: 0644

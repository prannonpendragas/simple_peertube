/etc/rundeck/project.properties:
  file.managed:
    - source: salt://tube_rundeck/config/project.properties
    - user: rundeck
    - group: rundeck
    - mode: 0640

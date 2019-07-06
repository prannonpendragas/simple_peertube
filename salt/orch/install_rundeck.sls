install_rundeck:
  salt.state:
    - tgt: 'tube_rundeck:enabled:True'
    - tgt_type: pillar
    - sls:
      - tube_apache
      - tube_rundeck.truststore
      - tube_rundeck.sudo
      - rundeck.repo
      - rundeck.install
      - rundeck.config
      - rundeck.plugins
      - rundeck.service
      - tube_rundeck.uwsgi
      - uwsgi.service
      - uwsgi.applications
      - tube_rundeck.config
      - tube_rundeck.acl
      - tube_rundeck.resources

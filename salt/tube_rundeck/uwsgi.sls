install_cgi_plugin_deps:
  pkg.installed:
    - pkgs:
      - make
      - gcc

'curl http://uwsgi.it/install | bash -s cgi /usr/bin/uwsgi':
  cmd.run:
    - runas: root
    - unless: test -f /usr/bin/uwsgi
    - require: 
      - pkg: install_cgi_plugin_deps

/opt/rundeck_uwsgi:
  file.recurse:
    - source: salt://tube_rundeck/uwsgi/
    - makedirs: True
    - user: rundeck
    - group: rundeck
    - file_mode: 0700
    - dir_mode: 0700

'systemctl restart uwsgi.service':
  cmd.run:
    - runas: root

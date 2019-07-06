uwsgi:
  applications:
    managed:
      tube_rundeck.ini:
        enabled: True
        config:
          - plugins: 'cgi'
            http: '127.0.0.1:8080'
            http-modifier1: '9'
            chdir: '/opt/rundeck_uwsgi'
            cgi: '/=/opt/rundeck_uwsgi'
            cgi-helper: '.py=python'
            cgi-allowed-ext: '.py'
            uid: 'rundeck'
            gid: 'rundeck'

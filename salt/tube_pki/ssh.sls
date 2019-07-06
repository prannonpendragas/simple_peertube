remove_existing_rundeck-svc_ssh_keys:
  file.absent:
    - name: /home/rundeck-svc/.ssh

generate_new_rundeck_ssh_key:
  cmd.run:
    - name: ssh-keygen -q -N '' -f /home/rundeck-svc/.ssh/id_rsa
    - runas: rundeck-svc

/srv/salt/tube_pki/keys/rundeck-svc_id_rsa:
  file.managed:
    - source: /home/rundeck-svc/.ssh/id_rsa
    - makedirs: True
    - user: root
    - group: root
    - mode: 0600
    - require: 
      - cmd: generate_new_rundeck_ssh_key

/srv/salt/tube_pki/keys/rundeck-svc_id_rsa.pub:
  file.managed:
    - source: /home/rundeck-svc/.ssh/id_rsa.pub
    - makedirs: True
    - user: root
    - group: root
    - mode: 0600
    - require: 
      - cmd: generate_new_rundeck_ssh_key

### RUNDECK
{%- if pillar.tube_rundeck is defined %}
  {%- if pillar.tube_rundeck.enabled == True %}
rundeck_group:
  group.present:
    - name: rundeck
    - gid: 9201

rundeck:
  user.present:
    - shell: /bin/bash
    - home: /var/lib/rundeck
    - uid: 9201
    - allow_uid_change: true
    - allow_gid_change: true
    - groups:
      - rundeck
      - adm
      - sudo

/var/lib/rundeck:
  file.directory:
    - user: rundeck
    - group: rundeck
    - recurse:
      - user
      - group
  {%- endif %}
{%- elif pillar.tube_nfs is defined %}
  {%- if pillar.tube_nfs.enabled == True %}
rundeck_group:
  group.present:
    - name: rundeck
    - gid: 9201

rundeck:
  user.present:
    - shell: /bin/false
    - home: /srv/rundeck_execution_logs
    - uid: 9201
    - groups:
      - rundeck 
  {%- endif %}
{%- endif %}

### RUNDECK-SVC
rundeck-svc_group:
  group.present:
    - name: rundeck-svc
    - gid: 9101

rundeck-svc:
  user.present:
    - shell: /bin/bash
    - home: /home/rundeck-svc
    - uid: 9101
    - allow_uid_change: true
    - allow_gid_change: true
    - groups:
      - rundeck-svc
      - adm
      - sudo
      - dip
      - plugdev

/home/rundeck-svc:
  file.directory:
    - user: rundeck-svc
    - group: rundeck-svc
    - recurse:
      - user
      - group

/var/lib/rundeck/var/uploads/:
  file.directory:
    - user: rundeck-svc
{%- if pillar.tube_rundeck is defined %}
  {%- if pillar.tube_rundeck.enabled == True %}
    - group: rundeck
    - mode: 0770
  {%- else %}
    - group: rundeck-svc
    - mode: 0700
  {%- endif %}
{%- endif %}
    - makedirs: True

{%- if pillar.tube_rundeck is defined %}
  {%- if pillar.tube_rundeck.enabled == True %}
/var/lib/rundeck/var/:
  file.directory:
    - user: rundeck-svc
    - group: rundeck
    - mode: 0770
  {%- endif %}
{%- endif %}

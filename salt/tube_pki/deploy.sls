{%- set hostname = grains['id'] %}
ssl-cert:
  group.present:
    - gid: 9003

/etc/ssl/private/:
  file.directory:
    - user: root
    - group: ssl-cert
    - dir_mode: 0770
    - makedirs: true

/etc/ssl/private/ca.crt:
  file.managed:
    - source: salt://tube_pki/keys/ca.crt
    - user: root
    - group: ssl-cert
    - mode: 0660

/etc/ssl/certs/ca.crt:
  file.managed:
    - source: salt://tube_pki/keys/ca.crt
    - user: root
    - group: root
    - mode: 0644

/etc/ssl/private/tube_pki.crt:
  file.managed:
    - source: salt://tube_pki/keys/{{ hostname }}.crt
    - user: root
    - group: ssl-cert
    - mode: 0660

/etc/ssl/private/tube_pki.key:
  file.managed:
    - source: salt://tube_pki/keys/{{ hostname }}.key
    - user: root
    - group: ssl-cert
    - mode: 0660

/etc/ssl/private/tube_pki.pem:
  file.append:
    - sources:
      - salt://tube_pki/keys/{{ hostname }}.crt
      - salt://tube_pki/keys/{{ hostname }}.key

correct_ownership_for_tube_pki.pem:
  file.managed:
    - name: /etc/ssl/private/tube_pki.pem
    - user: root
    - group: ssl-cert
    - mode: 0660

/etc/ssl/private/dhparams.pem:
  file.managed:
    - source: salt://tube_pki/keys/dhparams.pem
    - user: root
    - group: ssl-cert
    - mode: 0660

{%- if pillar.tube_openldap is defined %}
  {%- if pillar.tube_openldap.enabled == True %}
/etc/ssl/private/{{ pillar.tube.vars.master_domain }}.crt:
  file.managed:
    - source: salt://tube_pki/keys/{{ pillar.tube.vars.master_domain }}.crt
    - user: root
    - group: ssl-cert
    - mode: 0660
  
/etc/ssl/private/{{ pillar.tube.vars.master_domain }}.key:
  file.managed:
    - source: salt://tube_pki/keys/{{ pillar.tube.vars.master_domain }}.key
    - user: root
    - group: ssl-cert
    - mode: 0660
  {%- endif %}
{%- endif %}

{%- if pillar.tube_rundeck is defined %}
  {%- if pillar.tube_rundeck.enabled == True %}
/var/lib/rundeck/.ssh/id_rsa:
  file.managed:
    - source: salt://tube_pki/keys/rundeck-svc_id_rsa
    - makedirs: True
    - user: rundeck
    - group: rundeck
    - mode: 0600
  {%- endif %}
{%- endif %}
/home/rundeck-svc/.ssh/authorized_keys:
  file.managed:
    - source: salt://tube_pki/keys/rundeck-svc_id_rsa.pub
    - makedirs: true
    - user: rundeck-svc
    - group: rundeck-svc
    - mode: 0600

{%- set id = grains['server_id'] %}
tube:
  secrets:
    openldap:
{%- set ldap_rootpw = salt['cmd.shell']("echo "+id|string+" | sha1sum | cut -d- -f1") %}
{%- set ldap_crypt_salt = salt['cmd.shell']("head /dev/urandom | tr -dc A-Za-z0-9 | head -c4") %}
{%- set ldap_crypt_rootpw = salt['cmd.shell']("openssl passwd -1 -salt "+ldap_crypt_salt+" "+ldap_rootpw+" 2> /dev/null") %}
      ldap_base: "dc=greatview,dc=video"
      ldap_rootdn: "cn=master,dc=greatview,dc=video"
      ldap_rootpw: "{CRYPT}{{ ldap_crypt_rootpw }}"
      ldap_unencrypted_rootpw: "{{ ldap_rootpw }}"

    peertube:
{%- set peertube_db_password = salt['cmd.shell']('echo '+id|string+' | sha384sum | sha1sum | cut -d- -f1' ) %}
      peertube_database_password: "{{ peertube_db_password }}"

    rundeck:
{%- set rundeck_uuid = salt['cmd.shell']('uuidgen') %}
{%- set rundeck_db_password = salt['cmd.shell']('echo '+id|string+' | sha256sum | sha1sum | cut -d- -f1' ) %}
{%- set rundeck_admin_password = salt['cmd.shell']("echo "+id|string+" | sha1sum | sha256sum | cut -d- -f1") %} # edit this var to set a new password
{%- set rundeck_crypt_salt = salt['cmd.shell']("head /dev/urandom | tr -dc A-Za-z0-9 | head -c4") %}
{%- set rundeck_encrypted_password = salt['cmd.shell']("openssl passwd -1 -salt "+rundeck_crypt_salt+" "+rundeck_admin_password+" 2> /dev/null") %}
      rundeck_admin_password: "{CRYPT}{{ rundeck_encrypted_password }}"
      rundeck_admin_unencrypted_password: "{{ rundeck_admin_password }}"
      rundeck_admin_user: "tube_rundeck"
      rundeck_database_password: "{{ rundeck_db_password }}"
      rundeck_uuid: "{{ rundeck_uuid }}"

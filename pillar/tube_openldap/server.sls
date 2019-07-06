{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_openldap_secrets', tgt_type='pillar').items() %}
openldap:
  rootdn: '{{ secrets.ldap_rootdn }}'
  unencrypted_rootpw: '{{ secrets.ldap_unencrypted_rootpw }}'
  rootpw: '{{ secrets.ldap_rootpw }}'
  base: '{{ secrets.ldap_base }}'
  uri: 'ldap://localhost:389'
  user: 'openldap'
  group: 'openldap'
{%- if grains['ip4_interfaces']['eth0'] is defined %}
  {%- set address = grains['ip4_interfaces']['eth0'][1] %}
  slapd_services: 'ldap://{{ address }}/ ldaps:/// ldapi:///'
{%- endif %}
  slapd_options: '-4'
  lookup:
    index: objectClass
  includes:
    ssl.conf: |
      TLSCACertificateFile /etc/ssl/private/ca.crt
      TLSCertificateFile /etc/ssl/private/tube_pki.crt
      TLSCertificateKeyFile /etc/ssl/private/tube_pki.key
      TLSDHParamFile  /etc/ssl/private/dhparams.pem
{%- endfor %}

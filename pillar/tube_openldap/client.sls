{% for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
openldap:
  uri: 'ldaps://{{ vars.master_domain }}'
  tls_cacert: /etc/ssl/certs/ca.crt
  tls_cacertdir: /etc/ssl/certs
  tls_reqcert: allow
  sasl_nocanon: False
  lookup:
    client_config: /etc/ldap/ldap.conf
{%- endfor %}


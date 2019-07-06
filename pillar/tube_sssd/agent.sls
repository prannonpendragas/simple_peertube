{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
sssd:
  service:
    manage: True
  config:
    manage: True
    options:
      nss:
        filter_groups: root
        filter_users: root
        reconnection_retries: 3
      pam:
        reconnection_retries: 3
      sssd:
        config_file_version: 2
        reconnection_retries: 3
        sbus_timeout: 30
        services: 'nss, pam'
        domains: {{ vars.domain }}
      'domain/{{ vars.domain }}':
        enumerate: 'false'
        cache_credentials: 'true'
        id_provider: ldap
        access_provider: ldap
        auth_provider: ldap
        chpass_provider: none
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_openldap_secrets', tgt_type='pillar').items() %}
        ldap_uri: 'ldaps://{{ vars.master_domain }}'
        ldap_search_base: '{{ secrets.ldap_base }}'
        ldap_tls_reqcert: allow
        ldap_default_authtok_type: password
        ldap_access_filter: '(memberOf=cn=tube_linux,ou=Groups,{{ secrets.ldap_base }})'
  {%- endfor %}
{%- endfor %}

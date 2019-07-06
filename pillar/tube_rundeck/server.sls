{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_rundeck_secrets', tgt_type='pillar').items() %}
rundeck:
  enabled: True
  server:
    root_dir: '/var'
  profile:
    RDECK_JVM_OPTS: '-Djava.net.preferIPv4Stack=true -Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts -Drundeck.jetty.connector.forwarded=true'
  config:
  {%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
    server_url: https://rundeck.{{ vars.domain }}
    datasource:
      dbcreate: 'update'
      driverClassName: 'org.postgresql.Driver'
      url: 'jdbc:postgresql://{{ vars.data_domain }}/tube_rundeck?autoReconnect=true'
      username: 'tube_rundeck'
      password: "{{ secrets.rundeck_database_password }}"
    extra_opts:
      rundeck.projectsStorageType: 'db'
      dataSource.driverClassName: 'org.postgresql.Driver'
      dataSource.pooled: 'true'
      dataSource.properties.testOnBorrow: 'true'
      dataSource.properties.maxActive: '200'
      rundeck.storage.provider.1.type: 'db'
      rundeck.storage.provider.1.path: '/'
      rundeck.config.storage.provider.1.type: 'db'
      rundeck.config.storage.provider.1.path: '/'
      rundeck.log4j.config.file: '/etc/rundeck/log4j.properties'
      grails.controllers.upload.maxFileSize: '1024000000'
      grails.controllers.upload.maxRequestSize: '1024000000'
  framework:
    server_name: 'localhost'
    server_hostname: 'localhost'
    server_port: '4440'
    server_url: "https://rundeck.{{ vars.domain }}"
    server_uuid: "{{ secrets.rundeck_uuid }}"
    rundeck_disable_ref_stats: 'true'
    file_copy_destination_dir: '/var/lib/rundeck/var/uploads'
  login:
    ldap:
      flag: 'required'
      context_factory: 'com.sun.jndi.ldap.LdapCtxFactory'
      provider_url: "ldaps://{{ vars.master_domain }}"
  {%- endfor %} 
      ldaps_verify_hostname: "false"
      authentication_method: 'simple'
      force_binding_login: True
      force_binding_login_use_root_context_for_roles: True
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_openldap_secrets', tgt_type='pillar').items() %}
      user_base_dn: "ou=Users,{{ secrets.ldap_base }}"
      user_rdn_attribute: 'uid'
      user_id_attribute: 'uid'
      user_password_attribute: 'userPassword'
      user_object_class: 'inetOrgPerson'
      role_base_dn: "ou=Groups,{{ secrets.ldap_base }}"
  {%- endfor %}
      role_name_attribute: 'cn'
      role_member_attribute: 'member'
      role_object_class: 'groupOfNames'
      role_prefix: 'rundeck_'
      cache_duration_millis: '300000'
      supplemental_roles: 'user'
      timeout_read: '10000'
      timeout_connect: '20000'
      nested_groups: True
      try_first_pass: True
  realm:
{%- endfor %}

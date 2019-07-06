include:
  - openldap
{%- if pillar.tube_openldap is defined %}
  {%- if pillar.tube_openldap.enabled == True %}
  - tube_apache
  - tube_openldap.config
  - tube_openldap.users
  - tube_openldap.groups
  - tube_openldap.phpldapadmin
  - tube_openldap.self_service_password
  - tube_openldap.grain
  {%- endif %}
{%- endif %}

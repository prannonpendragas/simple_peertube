{%- for project, args in salt['pillar.get']('rundeck:client:project').items() %}
  {%- if project is defined %}

/etc/rundeck/{{ project|lower }}.aclpolicy:
  file.managed:
    - source: salt://tube_rundeck/acl/template.aclpolicy
    - template: jinja
    - user: rundeck
    - group: rundeck
    - mode: 0640
    - defaults:
      project: {{ project }}

  {%- endif %}
{%- endfor %}

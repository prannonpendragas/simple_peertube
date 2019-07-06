openldap:
  secrets:
{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_rundeck_secrets', tgt_type='pillar').items() %}
    rundeck_admin_user: "{{ secrets.rundeck_admin_user }}"
    rundeck_admin_password: "{{ secrets.rundeck_admin_password }}"
{%- endfor %}

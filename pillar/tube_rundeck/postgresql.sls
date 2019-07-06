{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_rundeck_secrets', tgt_type='pillar').items() %}
postgresql:
  server:
    database:
      tube_rundeck:
        encoding: 'UTF8'
        locale: 'en_US'
        users:
          - name: 'tube_rundeck'
            password: '{{ secrets.rundeck_database_password }}'
            host: '{{ vars.private_net }}.0/16'
            rights: 'all privileges'
  {%- endfor %}
{%- endfor %}

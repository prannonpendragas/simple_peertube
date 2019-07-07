{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_peertube_secrets', tgt_type='pillar').items() %}
postgresql:
  server:
    database:
      peertube_simple:
        encoding: 'UTF8'
        locale: 'en_US'
        users:
          - name: 'tube_peertube'
            password: '{{ secrets.peertube_database_password }}'
            host: '{{ vars.private_net }}.0/16'
            rights: 'all privileges'
        extension:
          pg_trgm:
            enabled: True
          unaccent:
            enabled: True
  {%- endfor %}
{%- endfor %}

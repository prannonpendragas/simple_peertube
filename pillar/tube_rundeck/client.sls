{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_rundeck_secrets', tgt_type='pillar').items() %}
rundeck:
  username: "{{ secrets.rundeck_admin_user }}"
  password: "{{ secrets.rundeck_admin_unencrypted_password }}"
  {%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
  url: 'https://rundeck.{{ vars.domain }}/'
  {%- endfor %}
  client:
    enabled: True
    secret:
      rundeck/top_user:
        type: password
        content: "{{ secrets.rundeck_admin_user }}"
      rundeck/top_password:
        type: password
        content: "{{ secrets.rundeck_admin_unencrypted_password }}"
    project:
      Node_Ops:
        description: Admin Operations against the whole platform
        plugin:
          import:
            address: https://github.com/prannonpendragas/simple_peertube.git
            format: yaml
            file_pattern: ".*Node_Ops.*\\.yaml"
      Peertube_Ops:
        description: Operations affecting Peertube only
        plugin:
          import:
            address: https://github.com/prannonpendragas/simple_peertube.git
            format: yaml
            file_pattern: ".*Peertube_Ops.*\\.yaml"
{%- endfor %}

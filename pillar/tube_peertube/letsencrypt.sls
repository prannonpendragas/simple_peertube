{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
letsencrypt:
  use_package: True
  pkgs:
    - python-certbot-nginx
  config: |
    server = https://acme-v01.api.letsencrypt.org/directory
    email = admin@{{ vars.domain }}
    post-hook = systemctl restart nginx
    authenticator = nginx
    agree-tos = True
    renew-by-default = True
  domainsets:
    www:
      - www.{{ vars.domain }}
      - {{ vars.domain }}
      - www.ldap.{{ vars.domain }}
      - ldap.{{ vars.domain }}
      - www.password.{{ vars.domain }}
      - password.{{ vars.domain }}
      - www.rundeck.{{ vars.domain }}
      - rundeck.{{ vars.domain }}
  post_renew:
    cmds:
      - systemctl restart nginx
  cron:
    minute: 42
    hour: 4
    dayweek: 3
{%- endfor %}

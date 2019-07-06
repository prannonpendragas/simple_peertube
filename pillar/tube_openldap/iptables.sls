{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
    389:
      ips_allow:
        - {{ vars.private_net }}.0/16
    636:
      ips_allow:
        - {{ vars.private_net }}.0/16
    443:
      ips_allow:
        - {{ vars.private_net }}.0/16
{%- endfor %}

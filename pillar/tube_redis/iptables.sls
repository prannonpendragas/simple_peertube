{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
    6379:
      protos:
        - tcp
      ips_allow:
        - {{ vars.private_net }}.0/16
{%- endfor %}

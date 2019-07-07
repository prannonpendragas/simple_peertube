{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  services:
    80:
      protos:
        - tcp
      ips_allow:
        - 0.0.0.0/0
    443:
      protos:
        - tcp
      ips_allow:
        - 0.0.0.0/0
{%- endfor %}

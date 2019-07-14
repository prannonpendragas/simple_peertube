{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  ipv6: True
  services:
    80:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/0
    443:
      protos:
        - tcp
      ips_allow:
        - {{ vars.public_net }}.0/0
  services_ipv6:
    80:
      protos:
        - tcp
    443:
      protos:
        - tcp
{%- endfor %}

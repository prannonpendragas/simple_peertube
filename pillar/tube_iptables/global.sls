{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
firewall:
  ipv6: True
  enabled: True
  install: True
  strict: True
  services:
    ssh:
      protos:
        - tcp
      ips_allow:
        - {{ vars.private_net }}.0/16
        - {{ vars.public_net }}.0/0
  services_ipv6:
    ssh:
      protos:
        - tcp
{%- endfor %}

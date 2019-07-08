dnsmasq:
  dnsmasq_conf: salt://dnsmasq/files/dnsmasq.conf
  settings:
    port: 53
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
    server: 
      - {{ vars.master_ip }}
{%- endfor %}
    no-resolv: True
    conf-dir: /etc/dnsmasq.d
    bind-dynamic: True
    local-service: True
resolver:
  use_resolvconf: True
  nameservers:
    - 127.0.0.1

{% for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
dnsmasq:
  dnsmasq_conf: salt://dnsmasq/files/dnsmasq.conf
  dnsmasq_addresses: salt://dnsmasq/files/dnsmasq.addresses
  settings:
    interface: eth0
    port: 53
    server:
      - 209.244.0.3
      - 209.244.0.4
      - 1.1.1.1
      - 1.0.0.1
    no-resolv: True
    no-hosts: True
  addresses:
### SYSTEM ADDRESSES
    ldap.{{ vars.domain }}: {{ vars.master_ip }}
    password.{{ vars.domain }}: {{ vars.master_ip }}
    rundeck.{{ vars.domain }}: {{ vars.master_ip }}

### NODE ADDRESSES
  {%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='*', fun='network.interfaces', tgt_type='glob').items() %}
    {%- if interfaces['eth0'] is defined %}
      {%- set eth0_public_addr = interfaces['eth0']['inet'][0]['address'] %}
      {%- set eth0_private_addr = interfaces['eth0']['inet'][1]['address'] %}
    {{ minion }}: {{ eth0_public_addr }}
    {{ minion }}.private: {{ eth0_private_addr }}
    {%- endif %}
  {%- endfor %}

resolver:
  use_resolvconf: True
  nameservers:
    - 127.0.0.1
{%- endfor %}

tube_dns:
  server:
    enabled: True

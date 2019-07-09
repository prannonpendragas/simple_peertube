postfix:
  manage_master_config: True
  enable_service: True
  reload_service: False
  config:
{%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='tube_rundeck:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
  {%- if interfaces['eth0'] is defined %}
    {%- set rundeck_addr = interfaces['eth0']['inet'][1]['address'] %}
    mynetworks: 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 {{ rundeck_addr }}/32
  {%- endif %}
{% endfor %}
{%- if grains['ip4_interfaces']['eth0'] is defined %}
  {%- set address = grains['ip4_interfaces']['eth0'][1] %}
    inet_interfaces: localhost {{ address }}
{%- endif %}

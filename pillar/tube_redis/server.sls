redis:
  server:
    enabled: True
    bind:
{%- if grains['ip4_interfaces']['eth0'] is defined %}
  {%- set address = grains['ip4_interfaces']['eth0'][1] %}
      address: {{ address }}
{%- endif %}
      port: 6379
      protocol: tcp

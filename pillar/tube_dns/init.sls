include:
{%- if 'master' in grains['id'] %}
  - tube_dns.server
  - tube_dns.iptables
{%- else %}
  - tube_dns.client
{%- endif %}

tube_dns:
  enabled: True

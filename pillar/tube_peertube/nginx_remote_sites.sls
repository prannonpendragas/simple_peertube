{%- set existing_sites = [] %}
nginx:
  servers:
    managed:
{%- for minion, sites in salt.saltutil.runner('mine.get', tgt='not I@tube_peertube:enabled:True', fun='get_nginx_configs', tgt_type='compound').items() | unique %}
  {%- if sites is not none %}
    {%- for site, parameters in sites.items() %}
      {%- if parameters is not none %}
        {%- if parameters not in existing_sites %}
      {{ site }}:
        {{ parameters|yaml(False)|indent(8) }}
          {%- do existing_sites.append(parameters) %}
        {%- endif %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}


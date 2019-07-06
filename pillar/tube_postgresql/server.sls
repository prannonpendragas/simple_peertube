{%- set existing_databases = [] %}
postgresql:
  server:
    enabled: True
    version: 11.4
    bind:
      address: {{ grains['ip4_interfaces']['eth0'][1] }}
      port: 5432
      protocol: tcp
    database:
{%- for minion, database_configs in salt.saltutil.runner('mine.get', tgt='*', fun='get_postgresql_configs', tgt_type='glob').items() | unique %}
  {%- if database_configs is not none %}
    {%- for database_config, parameters in database_configs.items() %}
      {%- if 'database' in database_config %}
        {%- if parameters is not none %}
          {%- if parameters not in existing_databases %}
      {{ parameters|yaml(False)|indent(6) }}
            {%- do existing_databases.append(parameters) %}
          {%- endif %}
        {%- endif %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}

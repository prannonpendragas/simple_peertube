include:
  - compunaut_salt.repo
  - compunaut_salt.minion
{%- if pillar.compunaut_salt is defined %}
  {%- if pillar.compunaut_salt.enabled == True %}
  - compunaut_salt.master
  - compunaut_salt.grain
  {%- endif %}
{%- endif %}

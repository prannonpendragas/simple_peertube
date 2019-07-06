include:
  - tube_salt.repo
  - tube_salt.minion
{%- if pillar.tube_salt is defined %}
  {%- if pillar.tube_salt.enabled == True %}
  - tube_salt.master
  - tube_salt.grains
  {%- endif %}
{%- endif %}

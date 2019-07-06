include:
{%- if pillar.tube_salt is defined %}
  {%- if pillar.tube_salt.enabled == True %}
  - tube_pki.ssh
  - tube_pki.ca
  - tube_pki.crt
  {%- endif %}
{%- endif %}
  - tube_pki.deploy

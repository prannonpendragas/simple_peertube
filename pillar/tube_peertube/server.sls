peertube:
  server:

{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
    webserver:
      hostname: {{ vars.domain }}

    trust_proxy: 
      - 'loopback'

  {%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='tube_postgresql:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
    {%- if interfaces['eth0'] is defined %}
      {%- set data_addr = interfaces['eth0']['inet'][1]['address'] %}
    database:
      hostname: {{ data_addr }}
      port: 5432
      suffix: _simple
      username: tube_peertube
      {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_peertube_secrets', tgt_type='pillar').items() %}
      password: {{ secrets.peertube_database_password }}
      {%- endfor %}

    redis:
      hostname: {{ data_addr }}
      port: 6379
    {%- endif %}
  {%- endfor %}

  {%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='tube_postfix:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
    {%- if interfaces['eth0'] is defined %}
      {%- set mail_addr = interfaces['eth0']['inet'][1]['address'] %}
    smtp:
      hostname: localhost # if your SMTP server is hosted on a different server, then set this to {{ mail_addr }}
      port: 25
      tls: false
      disable_starttls: true
      ca_file: /etc/ssl/certs/ca.crt
    {%- endif %}
  {%- endfor %}

    admin:
      email: admin@{{ vars.domain }}
{%- endfor %}

    contact_form:
      enabled: false

    signup:
      enabled: true
      limit: 5
      requires_email_verification: false

    transcoding:
      enabled: true
      allow_additional_extensions: true
      threads: 2
      resolutions:
        twofourty: true
        threesixty: true
        foureighty: true
        seventwenty: true
        teneighty: true

    import:
      videos:
        http:
          enabled: true
        torrent:
          enabled: false

    auto_blacklist:
      videos:
        of_users:
          enabled: true

    instance:
      name: 'Simple Peertube'
      short_description: 'A simple Peertube Instance.'
      description: ''
      terms: ''
      default_client_route: '/videos/trending'
      is_nsfw: true
      default_nsfw_policy: blur
      customizations:
        javascript: ''
        css: ''

    followers:
      instance:
        enabled: true
        manual_approval: true

peertube:
  server:
    webserver:
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
      hostname: {{ vars.domain }}
    trust_proxy: 
      - 'loopback'
    database:
      hostname: {{ vars.data_domain }}
      port: 5432
      suffix: _simple
      username: tube_peertube
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_peertube_secrets', tgt_type='pillar').items() %}
      password: {{ secrets.peertube_database_password }}
  {%- endfor %}
    redis:
      hostname: {{ vars.data_domain }}
      port: 6379
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
      short_description: 'A simple ready-to-scale Peertube Instance.'
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

{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
apache:
  manage_service_states: True
  sites:
    443-rundeck.{{ vars.domain }}:
      enabled: True
      template_file: salt://apache/vhosts/proxy.tmpl
      ServerName: rundeck.{{ vars.domain }}
      ServerAlias: rundeck.{{ vars.domain }}
      interface: '*'
      port: '443'
      SSLCertificateFile: /etc/ssl/private/tube_pki.pem
      ProxyRequests: 'Off'
      ProxyPreserveHost: 'On'
      ProxyRoute:
        route_to_local_rundeck:
          ProxyPassSource: '/'
          ProxyPassTarget: 'http://localhost:4440/'
          ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
          ProxyPassReverseSource: '/'
          ProxyPassReverseTarget: 'http://localhost:4440/'
{%- endfor %}

{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
apache:
  manage_service_states: True
  sites:
    80-phpldapadmin:
      interface: '*'
      port: '80'

    443-self-service-password:
      enabled: True
      template_file: salt://apache/vhosts/standard.tmpl
      ServerName: password.{{ vars.domain }}
      ServerAlias: password.{{ vars.domain }}
      interface: '*'
      port: '443'
      SSLCertificateFile: /etc/ssl/private/tube_pki.pem
      DocumentRoot: /usr/share/self-service-password
      DirectoryIndex: index.php
      Directory:
        default:
          AllowOverride: None
          Require: all granted
        /usr/share/self-service-password/scripts:
          AllowOverride: None
          Require: all denied
      
    443-ldap.{{ vars.domain }}:
      enabled: True
      template_file: salt://apache/vhosts/proxy.tmpl
      ServerName: ldap.{{ vars.domain }}
      ServerAlias: ldap.{{ vars.domain }}
      interface: '*'
      port: '443'
      SSLCertificateFile: /etc/ssl/private/tube_pki.pem
      ProxyRequests: 'Off'
      ProxyPreserveHost: 'On'
      ProxyRoute:
        route_to_local_ldap:
          ProxyPassSource: '/'
          ProxyPassTarget: 'http://localhost:80/'
          ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
          ProxyPassReverseSource: '/'
          ProxyPassReverseTarget: 'http://localhost:80/'
{%- endfor %}

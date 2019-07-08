nginx:
  servers:
    managed:
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
      http_rundeck.{{ vars.domain }}:
        enabled: True
        config:
          - server:
            - server_name:
              - www.rundeck.{{ vars.domain }}
              - rundeck.{{ vars.domain }}

            - listen:
              - '80'
              - '[::]:80'

            - access_log: /var/log/nginx/rundeck.{{ vars.domain }}.access.log
            - error_log: /var/log/nginx/rundeck.{{ vars.domain }}.error.log

            - location /:
              - return: 301 https://$host$request_uri

      https_www.rundeck.{{ vars.domain }}:
        enabled: True
        config:
          - server:
            - server_name:
              - www.rundeck.{{ vars.domain }}

            - listen:
              - '443 ssl http2'
              - '[::]:443 ssl http2'

            - access_log: /var/log/nginx/rundeck.{{ vars.domain }}.access.log
            - error_log: /var/log/nginx/rundeck.{{ vars.domain }}.error.log

            - ssl_certificate: /etc/ssl/private/tube_pki.crt
            - ssl_certificate_key: /etc/ssl/private/tube_pki.key
            - ssl_protocols: TLSv1.2
            - ssl_prefer_server_ciphers: "on"
            - ssl_ciphers: 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256'
            - ssl_session_timeout: 10m
            - ssl_session_cache: shared:SSL:10m
            - ssl_session_tickets: "off"
            - ssl_stapling: "on"
            - ssl_stapling_verify: "on"

            - location /:
              - return: 301 https://rundeck.{{ vars.domain }}$request_uri

      https_rundeck.{{ vars.domain }}:
        enabled: True
        config:
          - server:
            - server_name:
              - rundeck.{{ vars.domain }}

            - listen:
              - '443 ssl http2'
              - '[::]:443 ssl http2'

            - access_log: /var/log/nginx/rundeck.{{ vars.domain }}.access.log
            - error_log: /var/log/nginx/rundeck.{{ vars.domain }}.error.log

            - ssl_certificate: /etc/ssl/private/tube_pki.crt
            - ssl_certificate_key: /etc/ssl/private/tube_pki.key
            - ssl_protocols: TLSv1.2
            - ssl_prefer_server_ciphers: "on"
            - ssl_ciphers: 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256'
            - ssl_session_timeout: 10m
            - ssl_session_cache: shared:SSL:10m
            - ssl_session_tickets: "off"
            - ssl_stapling: "on"
            - ssl_stapling_verify: "on"

            - gzip: "on"
            - gzip_types: text/css application/javascript
            - gzip_vary: "on"

            - location /:
              - proxy_read_timeout: 1200s
              - proxy_set_header:
                - "X-Forwarded-For $proxy_add_x_forwarded_for"
                - "Host $host"
  {%- if grains['ip4_interfaces']['eth0'] is defined %}
    {%- set address = grains['ip4_interfaces']['eth0'][1] %}
              - proxy_pass: https://{{ address }}:443/
  {%- endif %}
{%- endfor %}

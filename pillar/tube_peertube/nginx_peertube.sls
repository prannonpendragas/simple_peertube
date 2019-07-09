{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='tube_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
nginx:
  servers:
    managed:
      certbot_{{ vars.domain }}:
        enabled: True
        overwrite: True
        config:
          # Refer to https://github.com/Chocobozzz/PeerTube/blob/develop/support/nginx/peertube
          - server:
            - server_name: 
              - www.{{ vars.domain }}
              - {{ vars.domain }}

            - listen:
              - '80'
              - '[::]:80'

            - access_log: /var/log/nginx/{{ vars.domain }}.access.log
            - error_log: /var/log/nginx/{{ vars.domain }}.error.log

            - location /.well-known/acme-challenge/:
              - default_type: "'text/plain'"
              - root: /var/www/certbot

            - location /:
              - return: 301 https://$host$request_uri

      https_www.{{ vars.domain }}:
        enabled: False # Set to false for the initial run; Once certbot certs are configured, then set to True
        overwrite: True
        config:
          # Refer to https://github.com/Chocobozzz/PeerTube/blob/develop/support/nginx/peertube
          - server:
            - server_name:
              - www.{{ vars.domain }}

            - listen:
              - '443 ssl http2'
              - '[::]:443 ssl http2'

            - access_log: /var/log/nginx/{{ vars.domain }}.access.log
            - error_log: /var/log/nginx/{{ vars.domain }}.error.log

            - ssl_certificate: /etc/letsencrypt/live/www.{{ vars.domain }}/fullchain.pem
            - ssl_certificate_key: /etc/letsencrypt/live/www.{{ vars.domain }}/privkey.pem
            - ssl_protocols: TLSv1.2
            - ssl_prefer_server_ciphers: "on"
            - ssl_ciphers: 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256'
            - ssl_session_timeout: 10m
            - ssl_session_cache: shared:SSL:10m
            - ssl_session_tickets: "off"
            - ssl_stapling: "on"
            - ssl_stapling_verify: "on"

            - add_header: "Strict-Transport-Security 'max-age=63072000; includeSubDomains'"

            - location /:
              - return: 301 https://{{ vars.domain }}$request_uri

      https_{{ vars.domain }}:
        enabled: False # Set to false for the initial run; Once certbot certs are configured, then set to True
        overwrite: True
        config:
          # Refer to https://github.com/Chocobozzz/PeerTube/blob/develop/support/nginx/peertube
          - server:
            - server_name:
              - {{ vars.domain }}

            - listen:
              - '443 ssl http2'
              - '[::]:443 ssl http2'

            - access_log: /var/log/nginx/{{ vars.domain }}.access.log
            - error_log: /var/log/nginx/{{ vars.domain }}.error.log

            - ssl_certificate: /etc/letsencrypt/live/www.{{ vars.domain }}/fullchain.pem
            - ssl_certificate_key: /etc/letsencrypt/live/www.{{ vars.domain }}/privkey.pem
            - ssl_protocols: TLSv1.2
            - ssl_prefer_server_ciphers: "on"
            - ssl_ciphers: 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256'
            - ssl_session_timeout: 10m
            - ssl_session_cache: shared:SSL:10m
            - ssl_session_tickets: "off"
            - ssl_stapling: "on"
            - ssl_stapling_verify: "on"

            - add_header: "Strict-Transport-Security 'max-age=63072000; includeSubDomains'"

            - gzip: "on"
            - gzip_types: text/css application/javascript
            - gzip_vary: "on"

            - location ^~ '/.well-known/acme-challenge':
              - default_type: "'text/plain'"
              - root: /var/www/certbot

            - location ~ ^/client/(.*\.(js|css|woff2|otf|ttf|woff|eot))$:
              - add_header: Cache-Control "public, max-age=31536000, immutable"
              - alias: /var/www/peertube/peertube-latest/client/dist/$1

            - location ~ ^/static/(thumbnails|avatars)/:
              - if ($request_method = 'OPTIONS'):
                - add_header:
                  - "'Access-Control-Allow-Origin' '*'"
                  - "'Access-Control-Allow-Methods' 'GET, OPTIONS'"
                  - "'Access-Control-Allow-Headers' 'Range,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type'"
                  - "'Access-Control-Max-Age' 1728000"
                  - "'Content-Type' 'text/plain charset=UTF-8'"
                  - "'Content-Length' 0"
                - return: 204
              - add_header:
                - "'Access-Control-Allow-Origin' '*'"
                - "'Access-Control-Allow-Methods' 'GET, OPTIONS'"
                - "'Access-Control-Allow-Headers' 'Range,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type'"
                - "Cache-Control 'public, max-age=7200'"
              - root: /var/www/peertube/storage
              - rewrite: ^/static/(thumbnails|avatars)/(.*)$ /$1/$2 break
              - try_files: $uri /

            - location /:
              - proxy_pass: http://localhost:9000
              - proxy_set_header:
                - X-Real-IP $remote_addr
                - Host $host
                - X-Forwarded-For $proxy_add_x_forwarded_for
              - client_max_body_size: 8G
              - proxy_connect_timeout: 600
              - proxy_send_timeout: 600
              - proxy_read_timeout: 600
              - send_timeout: 600

            - location ~ ^/static/(webseed|redundancy)/:
              - limit_rate: 800k
              - if ($request_method = 'OPTIONS'):
                - add_header:
                  - "'Access-Control-Allow-Origin' '*'"
                  - "'Access-Control-Allow-Methods' 'GET, OPTIONS'"
                  - "'Access-Control-Allow-Headers' 'Range,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type'"
                  - "'Access-Control-Max-Age' 1728000"
                  - "'Content-Type' 'text/plain charset=UTF-8'"
                  - "'Content-Length' 0"
                - return: 204
              - if ($request_method = 'GET'):
                - add_header:
                  - "'Access-Control-Allow-Origin' '*'"
                  - "'Access-Control-Allow-Methods' 'GET, OPTIONS'"
                  - "'Access-Control-Allow-Headers' 'Range,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type'"
                - access_log: off
              - root: /var/www/peertube/storage
              - rewrite:
                - "^/static/webseed/(.*)$ /videos/$1 break"
                - "^/static/redundancy/(.*)$ /redundancy/$1 break"
              - try_files: $uri /

            - location /tracker/socket:
              - proxy_read_timeout: 1200s
              - proxy_set_header:
                - "Upgrade $http_upgrade"
                - "Connection 'upgrade'"
                - "X-Forwarded-For $proxy_add_x_forwarded_for"
                - "Host $host"
              - proxy_http_version: 1.1
              - proxy_pass: http://localhost:9000

            - location /socket.io:
              - proxy_set_header:
                - "X-Forwarded-For $proxy_add_x_forwarded_for"
                - "Host $host"
                - "Upgrade $http_upgrade"
                - "Connection 'upgrade'"
              - proxy_http_version: 1.1
              - proxy_pass: http://localhost:9000
{%- endfor %}

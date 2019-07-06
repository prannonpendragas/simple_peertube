include:
  - apache
  - apache.mod_ssl
  - apache.mod_proxy
  - apache.mod_proxy_http
  - apache.config
  - apache.vhosts.standard

reload_apache2_on_state_change:
  service.running:
    - name: apache2
    - enable: True
    - reload: True
    - watch:
      - sls: apache
      - sls: apache.mod_ssl
      - sls: apache.mod_proxy
      - sls: apache.mod_proxy_http
      - sls: apache.config
      - sls: apache.vhosts.standard

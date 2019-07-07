include:
  - tube_peertube.config

peertube.service:
  service.running:
    - enable: True
    - watch:
      - file: /var/www/peertube/config/production.yaml
      - file: /etc/systemd/system/peertube.service

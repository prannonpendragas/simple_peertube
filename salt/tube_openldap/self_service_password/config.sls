/usr/share/self-service-password/conf/config.inc.php:
  file.managed:
    - source: salt://tube_openldap/self_service_password/config/config.inc.php
    - template: jinja
    - user: root
    - group: www-data
    - mode: 0640

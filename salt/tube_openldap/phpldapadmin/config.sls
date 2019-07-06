/etc/phpldapadmin/config.php:
  file.managed:
    - template: jinja
    - source: salt://tube_openldap/phpldapadmin/config/config.php
    - user: root
    - group: www-data
    - mode: 0640

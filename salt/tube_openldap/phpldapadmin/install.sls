install_phpldapadmin:
  pkg.installed:
    - pkgs:
      - apache2
      - php
      - libapache2-mod-php
      - phpldapadmin

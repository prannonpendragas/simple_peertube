install-self-service-password:
  pkg.installed:
    - pkgs:
      - php-mbstring
      - self-service-password

restart_apache2_for_ssp:
  cmd.run:
    - name: 'systemctl restart apache2'
    - watch:
      - pkg: install-self-service-password

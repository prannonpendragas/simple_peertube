include:
  - tube_openldap.config.replication

restart_slapd:
  cmd.run:
    - name: systemctl restart slapd
    - onchanges:
      - ldap: manage_repl_config

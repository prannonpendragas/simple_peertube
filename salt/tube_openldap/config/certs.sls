openldap_user:
  user.present:
    - name: openldap
    - remove_groups: False
    - groups:
      - ssl-cert

ensure_ssl_dir_group:
  file.directory:
    - name: /etc/ssl/private
    - user: root
    - group: ssl-cert
    - dir_mode: 0770
    - makedirs: true

restart_slapd_before_certs:
  cmd.run:
    - name: systemctl restart slapd

wait_before_certs:
  cmd.run:
    - name: sleep 15

manage_certificates:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          method: sasl
          mechanism: EXTERNAL
    - entries:
      - 'cn=config':
        - replace:
            olcTLSCACertificateFile: /etc/ssl/private/ca.crt
            olcTLSCertificateFile: /etc/ssl/private/tube-openldap.service.crt
            olcTLSCertificateKeyFile: /etc/ssl/private/tube-openldap.service.key
            olcTLSDHParamFile: /etc/ssl/private/dhparams.pem

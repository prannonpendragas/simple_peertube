python-m2crypto:
  pkg.installed: []

/srv/salt/tube_pki/keys/ca.key:
  x509.private_key_managed:
    - bits: 4096

/srv/salt/tube_pki/keys/ca.crt:
  x509.certificate_managed:
    - signing_private_key: /srv/salt/tube_pki/keys/ca.key
    - CN: ca.tube.prannon.net
    - C: US
    - ST: Texas
    - L: Austin
    - basicConstraints: "critical CA:true"
    - subjectKeyIdentifier: hash
    - authorityKeyIdentifier: keyid,issuer:always
    - days_valid: 3650
    - days_remaining: 0
    - require:
      - pkg: python-m2crypto

/srv/salt/tube_pki/keys/dhparams.pem:
  cmd.run:
    - name: openssl dhparam -dsaparam -out /srv/salt/tube_pki/keys/dhparams.pem 4096
    - unless: test -f /srv/salt/tube_pki/keys/dhparams.pem

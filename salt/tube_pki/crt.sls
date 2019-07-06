{%- for minion, hostname in salt['mine.get']('*', 'network.get_hostname').iteritems()|sort %}
/srv/salt/tube_pki/keys/{{ hostname }}.key:
  x509.private_key_managed:
    - bits: 4096

/srv/salt/tube_pki/keys/{{ hostname }}.csr:
  x509.csr_managed:
    - private_key: /srv/salt/tube_pki/keys/{{ hostname }}.key
    - CN: {{ hostname }}
    - C: US
    - ST: Texas
    - L: Austin
    - keyUsage: "keyEncipherment,keyAgreement,digitalSignature"
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'

/srv/salt/tube_pki/keys/{{ hostname }}.crt:
  x509.certificate_managed:
    - signing_private_key: /srv/salt/tube_pki/keys/ca.key
    - signing_cert: /srv/salt/tube_pki/keys/ca.crt
    - csr: /srv/salt/tube_pki/keys/{{ hostname }}.csr
    - keyUsage: 'keyEncipherment,keyAgreement,digitalSignature'
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'
    - days_valid: 3650
    - days_remaining: 0
    - CN: {{ hostname }}
    - C: US
    - ST: Texas
    - L: Austin
{%- endfor %}

/srv/salt/tube_pki/keys/{{ pillar.tube.vars.master_domain }}.key:
  x509.private_key_managed:
    - bits: 4096

/srv/salt/tube_pki/keys/{{ pillar.tube.vars.master_domain }}.csr:
  x509.csr_managed:
    - private_key: /srv/salt/tube_pki/keys/{{ pillar.tube.vars.master_domain }}.key
    - CN: {{ pillar.tube.vars.master_domain }}
    - C: US
    - ST: Texas
    - L: Austin
    - keyUsage: "keyEncipherment,keyAgreement,digitalSignature"
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'

/srv/salt/tube_pki/keys/{{ pillar.tube.vars.master_domain }}.crt:
  x509.certificate_managed:
    - signing_private_key: /srv/salt/tube_pki/keys/ca.key
    - signing_cert: /srv/salt/tube_pki/keys/ca.crt
    - csr: /srv/salt/tube_pki/keys/{{ pillar.tube.vars.master_domain }}.csr
    - keyUsage: 'keyEncipherment,keyAgreement,digitalSignature'
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'
    - days_valid: 3650
    - days_remaining: 0
    - CN: {{ pillar.tube.vars.master_domain }}
    - C: US
    - ST: Texas
    - L: Austin

python-ldap:
  pkg.installed

manage_rootdn:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          method: sasl
          mechanism: EXTERNAL
    - entries:
      - 'olcDatabase={1}mdb,cn=config':
        - replace:
            olcSuffix: "{{ pillar.openldap.base }}"
            olcRootDN: "{{ pillar.openldap.rootdn }}"
            olcRootPW: "{{ pillar.openldap.rootpw }}"

manage_compunaut_rootdn_and_base:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          dn: "{{ pillar.openldap.rootdn }}"
          password: "{{ pillar.openldap.unencrypted_rootpw }}"
    - entries:
      - 'cn=admin,{{ pillar.openldap.base }}':
        - delete_others: True
      - '{{ pillar.openldap.base }}':
        - default:
            objectClass:
              - dcObject
              - organization
            dc:
              - compunaut
            o:
              - Compunaut
            description:
              - Compunaut Fleet Controller
      - '{{ pillar.openldap.rootdn }}':
        - default:
            cn:
              - compunaut
            objectClass:
              - organizationalRole
            description:
              - CFC LDAP Admin

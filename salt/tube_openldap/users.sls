manage_tube_login_users:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          dn: "{{ pillar.openldap.rootdn }}"
          password: "{{ pillar.openldap.unencrypted_rootpw }}"
    - entries:
      - 'ou=Users,{{ pillar.openldap.base }}':
        - replace:
            ou:
              - Users
            objectClass:
              - organizationalUnit
      - "cn=tube_system,ou=Users,{{ pillar.openldap.base }}":
        - replace:
            cn:
              - tube_system
            sn:
              - tube_system
            uid:
              - tube_system
            objectClass:
              - top
              - inetOrgPerson
              - posixAccount
            gidNumber: 1500
            uidNumber: 1000
            homeDirectory: /home/tube_system
            loginShell: /bin/false
            description:
              - This user does nothing; it only exists to initialize groups
      - "cn={{ pillar.openldap.secrets.rundeck_admin_user }},ou=Users,{{ pillar.openldap.base }}":
        - replace:
            cn:
              - {{ pillar.openldap.secrets.rundeck_admin_user }}
            sn:
              - {{ pillar.openldap.secrets.rundeck_admin_user }}
            uid:
              - {{ pillar.openldap.secrets.rundeck_admin_user }}
            objectClass:
              - top
              - inetOrgPerson
              - posixAccount
            gidNumber: 1502
            uidNumber: 1000
            homeDirectory: /home/{{ pillar.openldap.secrets.rundeck_admin_user }}
            loginShell: /bin/false
            userPassword: "{{ pillar.openldap.secrets.rundeck_admin_password }}"
            description:
              - Generic Rundeck Admin User

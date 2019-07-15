{%- set existing_groups = [] %}
manage_tube_login_groups:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          dn: "{{ pillar.openldap.rootdn }}"
          password: "{{ pillar.openldap.unencrypted_rootpw }}"
    - entries:
      - 'ou=Groups,{{ pillar.openldap.base }}':
        - replace:
            ou:
              - Groups
            objectClass:
              - organizationalUnit
      - 'cn=tube_ldap_admin,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - tube_ldap_admin
            objectClass:
              - top
              - groupOfNames
            member:
              - cn=tube_system,ou=Users,{{ pillar.openldap.base }}
            description:
              - Add users to this group if they need to be able to modify existing users and groups. USERS IN THIS GROUP CANNOT CREATE/DELETE USERS OR GROUPS.
      - 'cn=tube_users,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - tube_users
            objectClass:
              - top
              - posixGroup
            gidNumber: 1500
            description:
              - This group does nothing; it exists only as a generic group for all users
      - 'cn=tube_sudo,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - sudo
              - tube_sudo
            objectClass:
              - top
              - posixGroup
            gidNumber: 27
            memberUid:
              - tube_system
            description:
              - Add users to this group if they should have ROOT access to the linux servers.
      - 'cn=tube_peertube,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - peertube
              - tube_peertube
            objectClass:
              - top
              - posixGroup
            gidNumber: 9202
            memberUid:
              - tube_system
            description:
              - Add users to this group if they should have access to the peertube site files.
      - 'cn=tube_linux,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - tube_linux
            objectClass:
              - top
              - groupOfNames
            member:
              - cn=tube_system,ou=Users,{{ pillar.openldap.base }}
            description:
              - Add users to this group if they should be able to log into the linux servers. This is useful for SFTP or SSH access.
      - 'cn=rundeck_admin,ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - rundeck_admin
            objectClass:
              - top
              - groupOfNames
            member:
              - cn={{ pillar.openldap.secrets.rundeck_admin_user }},ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for Rundeck Admins.
{%- for minion, projects in salt['mine.get']('tube_rundeck:enabled:True', fun='get_rundeck_projects', tgt_type='pillar').iteritems() %}
  {%- if projects is defined %}
    {%- for project, args in projects.items() %}
      {%- if project not in existing_groups %}
      - 'cn=rundeck_{{ project|lower }},ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn: 
              - rundeck_{{ project|lower }}
            objectClass:
              - top
              - groupOfNames
            member:
              - cn={{ pillar.openldap.secrets.rundeck_admin_user }},ou=Users,{{ pillar.openldap.base }}
            description:
              - Group for access to the {{ project }} Rundeck project.
        {% do existing_groups.append(project) %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}

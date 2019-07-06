manage_memberOf:
  ldap.managed:
    - unless: test -f /etc/ldap/slapd.d/cn\=config/cn\=module\{1\}.ldif
    - connect_spec:
        url: ldapi:///
        bind:
          method: sasl
          mechanism: EXTERNAL
    - entries:
      - 'cn=module,cn=config':
        - default:
            objectClass:
              - olcModuleList
            olcModulePath: /usr/lib/ldap
            olcModuleLoad:
              - memberof.la
              - refint.la
      - 'olcOverlay=memberof,olcDatabase={1}mdb,cn=config':
        - default:
            objectClass: 
              - olcConfig
              - olcMemberOf
              - olcOverlayConfig
              - top
            olcOverlay: memberof
            olcMemberOfDangling: ignore
            olcMemberOfRefInt: "TRUE"
            olcMemberOfGroupOC: groupOfNames
            olcMemberOfMemberAD: member
            olcMemberOfMemberOfAD: memberOf
      - 'olcOverlay=refint,olcDatabase={1}mdb,cn=config':
        - default:
            objectClass:
              - olcConfig
              - olcOverlayConfig
              - olcRefintConfig
              - top
            olcOverlay: refint
            olcRefintAttribute: memberof member manager owner

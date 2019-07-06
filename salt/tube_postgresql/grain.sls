postgresql_role:
  grains.list_present:
    - name: role
    - value:
      - postgresql_server

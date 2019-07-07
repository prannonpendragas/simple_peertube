salt_master_role:
  grains.list_present:
    - name: role
    - value: 
      - salt_master

# the pam module puts in the right stuff, but this enables it
enable_mkhomedir:
  cmd.run:
    - name: "sed -i '/mkhomedir/d' /var/lib/pam/seen && pam-auth-update --package"
    - runas: root

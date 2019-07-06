give_rundeck_sudo:
  user.present:
    - name: rundeck
    - groups:
      - rundeck
      - sudo

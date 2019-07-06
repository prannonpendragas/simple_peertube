self-service-password.repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://ltb-project.org/debian/jessie jessie main
    - file: /etc/apt/sources.list.d/self-service-password.list
    - key_url: https://ltb-project.org/wiki/lib/RPM-GPG-KEY-LTB-project

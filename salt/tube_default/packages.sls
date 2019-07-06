install_default_packages:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - curl
      - htop
      - jq
      - mlocate
      - monitoring-plugins
      - monitoring-plugins-basic
      - monitoring-plugins-common
      - monitoring-plugins-standard
      - openssh-server
      - python-pip
      - software-properties-common
      - sshpass
      - uuid-runtime
      - vim

install_default_python_modules:
  pip.installed:
    - pkgs:
      - pynag
      - ruamel.yaml

ssh_service:
  service.running:
    - name: ssh
    - enable: True

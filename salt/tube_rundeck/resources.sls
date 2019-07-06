install_resource_dependencies:
  pkg.installed:
    - pkgs:
      - git

/opt/rundeck/scripts/:
  file.directory:
    - user: rundeck
    - group: rundeck
    - dir_mode: 0750
    - makedirs: True

https://github.com/prannonpendragas/salt-gen-resource.git:
  git.cloned:
    - target: /opt/rundeck/scripts/salt-gen-resource
    - user: rundeck
    - require:
      - file: /opt/rundeck/scripts/

/etc/sudoers.d/99-salt-gen-resource:
  file.managed:
    - contents: |
        Cmnd_Alias SALT_GEN_RESOURCE = /opt/rundeck/scripts/salt-gen-resource/SaltGenResource.py
        rundeck ALL=(root) NOPASSWD: SALT_GEN_RESOURCE
        Defaults!SALT_GEN_RESOURCE !requiretty
    - user: root
    - group: root
    - mode: 0440

{% set version = "v1.3.1" %}
{% set hash = "20957d28c8758759d97c61f82f9baaabf8cb1dbce2c43b4c97792b75dd40ec23" %}

/var/www/peertube/config:
  file.directory:
    - user: peertube
    - group: peertube
    - dir_mode: 0750
    - makedirs: True

/var/www/peertube/storage:
  file.directory:
    - user: peertube
    - group: www-data
    - dir_mode: 0750
    - makedirs: True

/var/www/peertube/versions:
  file.directory:
    - user: peertube
    - group: www-data
    - dir_mode: 0755
    - makedirs: True

/var/www/peertube/versions/:
  archive.extracted:
    - source: https://github.com/Chocobozzz/PeerTube/releases/download/{{ version }}/peertube-{{ version }}.zip
    - source_hash: {{ hash }}
    - archive_format: zip
    - user: peertube
    - group: peertube
    - require:
      - file: /var/www/peertube/versions

/var/www/peertube/peertube-latest:
  file.symlink:
    - target: /var/www/peertube/versions/peertube-{{ version }}
    - user: peertube
    - group: www-data
    - makedirs: True
    - require:
      - archive: /var/www/peertube/versions/

install_peertube:
  cmd.run:
    - cwd: /var/www/peertube/peertube-latest
    - runas: peertube
    - name: yarn install --production --pure-lockfile

/var/www/peertube/versions/peertube-{{ version }}/client/dist/en_US:
  file.directory:
    - user: peertube
    - group: peertube
    - dir_mode: 0775
    - require:
      - cmd: install_peertube
  cmd.run:
    - name: find /var/www/peertube/versions/peertube-{{ version }}/client/dist/en_US -type f -exec chmod 0664 {} \;
    - runas: root
    - require:
      - cmd: install_peertube

/var/www/peertube/versions/peertube-{{ version }}/client/dist/assets/images:
  file.directory:
    - user: peertube
    - group: peertube
    - dir_mode: 0775
    - recurse:
      - user
      - group
      - mode
    - require:
      - cmd: install_peertube
  cmd.run:
    - name: find /var/www/peertube/versions/peertube-{{ version }}/client/dist/assets/images -type f -exec chmod 0664 {} \;
    - runas: root
    - require:
      - cmd: install_peertube

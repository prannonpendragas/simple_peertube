/var/www/peertube/config:
  file.directory:
    - user: peertube
    - group: peertube
    - dir_mode: 0750
    - makedirs: True

/var/www/peertube/storage:
  file.directory:
    - user: peertube
    - group: peertube
    - dir_mode: 0750
    - makedirs: True

/var/www/peertube/versions:
  file.directory:
    - user: peertube
    - group: www-data
    - dir_mode: 0750
    - makedirs: True

/var/www/peertube/versions/:
  archive.extracted:
    - source: https://github.com/Chocobozzz/PeerTube/releases/download/v1.3.1/peertube-v1.3.1.zip
    - source_hash: 20957d28c8758759d97c61f82f9baaabf8cb1dbce2c43b4c97792b75dd40ec23
    - archive_format: zip
    - user: peertube
    - group: peertube
    - require:
      - file: /var/www/peertube/versions

/var/www/peertube/peertube-latest:
  file.symlink:
    - target: /var/www/peertube/versions/peertube-v1.3.1
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

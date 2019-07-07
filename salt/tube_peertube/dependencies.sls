# Refer to https://docs.joinpeertube.org/#/dependencies
# Refer to https://github.com/nodesource/distributions/blob/master/README.md#deb
# Refer to https://yarnpkg.com/en/docs/install#debian-stable
install_peertube_dependencies:
  pkg.installed:
    - pkgs:
      - certbot
      - curl
      - ffmpeg
      - g++
      - git
      - make
      - nginx
      - nodejs
      - openssl
      - python-certbot-nginx
      - python-dev
      - sudo
      - unzip
      - vim
      - yarn

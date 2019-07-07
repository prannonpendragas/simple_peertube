# Refer to https://docs.joinpeertube.org/#/dependencies
# Refer to https://github.com/nodesource/distributions/blob/master/README.md#deb
# Refer to https://yarnpkg.com/en/docs/install#debian-stable
install_peertube_dependencies:
  pkg.installed:
    - pkgs:
      - curl
      - ffmpeg
      - g++
      - git
      - make
      - nodejs
      - openssl
      - python-dev
      - sudo
      - unzip
      - vim
      - yarn

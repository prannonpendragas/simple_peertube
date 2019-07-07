# Refer to https://certbot.eff.org/lets-encrypt/ubuntuxenial-nginx.html
'add-apt-repository universe':
  cmd.run:
    - runas: root

certbot_repo:
  pkgrepo.managed:
    - name: deb http://ppa.launchpad.net/certbot/certbot/ubuntu xenial main
    - file: /etc/apt/sources.list.d/certbot-ubuntu-certbot-xenial.list
    - keyid: 75BCA694
    - keyserver: keyserver.ubuntu.com

# Refer to https://docs.joinpeertube.org/#/dependencies
ffmpeg_repo:
  pkgrepo.managed:
    - name: deb http://ppa.launchpad.net/jonathonf/ffmpeg-3/ubuntu xenial main
    - file: /etc/apt/sources.list.d/jonathonf-ubuntu-ffmpeg-3-xenial.list
    - keyid: F06FC659
    - keyserver: keyserver.ubuntu.com

# Refer to https://github.com/nodesource/distributions/blob/master/README.md#deb
nodesource_repo:
  pkgrepo.managed:
    - name: deb https://deb.nodesource.com/node_8.x xenial main
    - file: /etc/apt/sources.list.d/nodesource.list
    - keyid: AA01DA2C
    - keyserver: keyserver.ubuntu.com

nodesource_src_repo:
  pkgrepo.managed:
    - name: deb-src https://deb.nodesource.com/node_8.x xenial main
    - file: /etc/apt/sources.list.d/nodesource_src.list
    - keyid: AA01DA2C
    - keyserver: keyserver.ubuntu.com

# Refer to https://yarnpkg.com/en/docs/install#debian-stable
yarn_repo:
  pkgrepo.managed:
    - name: deb https://dl.yarnpkg.com/debian/ stable main
    - file: /etc/apt/sources.list.d/yarn.list
    - keyid: 86E50310
    - keyserver: keyserver.ubuntu.com

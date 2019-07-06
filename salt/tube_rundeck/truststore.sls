ca-certificates-java:
  pkg.installed

'keytool -noprompt -import -alias Tube_CA -file /etc/ssl/private/ca.crt -keystore /etc/ssl/certs/java/cacerts -storepass changeit':
  cmd.run:
    - runas: root

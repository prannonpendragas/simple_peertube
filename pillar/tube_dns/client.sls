dnsmasq:
  dnsmasq_conf: salt://dnsmasq/files/dnsmasq.conf
  settings:
    port: 53
    server: 
      - 192.168.220.5
    no-resolv: True
    conf-dir: /etc/dnsmasq.d
    bind-dynamic: True
    local-service: True
resolver:
  use_resolvconf: True
  nameservers:
    - 127.0.0.1

router_advertisement:
  iptables.append:
    - chain: INPUT
    - family: ipv6
    - protocol: icmpv6
    - icmpv6-type: router-advertisement
    - match: hl
    - hl-eq: 255
    - jump: ACCEPT
    - save: true

neighbor_solicitation:
  iptables.append:
    - chain: INPUT
    - family: ipv6
    - protocol: icmpv6
    - icmpv6-type: neighbor-solicitation
    - match: hl
    - hl-eq: 255
    - jump: ACCEPT
    - save: true

neighbor_advertisement:
  iptables.append:
    - chain: INPUT
    - family: ipv6
    - protocol: icmpv6
    - icmpv6-type: neighbor-advertisement
    - match: hl
    - hl-eq: 255
    - jump: ACCEPT
    - save: true

redirect:
  iptables.append:
    - chain: INPUT
    - family: ipv6
    - protocol: icmpv6
    - icmpv6-type: redirect
    - match: hl
    - hl-eq: 255
    - jump: ACCEPT
    - save: true

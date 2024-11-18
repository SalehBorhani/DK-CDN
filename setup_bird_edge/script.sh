#!/bin/bash

cat <<EOF > /etc/bird/bird.conf
router id 192.168.20.4;

protocol kernel {
  persist;
  scan time 20;
  import all;
  export all;
}

protocol device {
    scan time 10;
}

protocol bgp edge {
  local as 65002;
  neighbor 192.168.20.3 as 65001;
  import all;
  export all;
}
EOF

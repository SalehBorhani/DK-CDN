#!/bin/bash

cat <<EOF > /etc/bird/bird.conf
router id 192.168.20.3;

protocol kernel {
  persist;
  scan time 20;
  import all;
  export all;
}

protocol device {
    scan time 10;
}

protocol bgp isp {
  local as 65001;
  neighbor 192.168.20.4 as 65002;
  import all;
  export all;
}
EOF

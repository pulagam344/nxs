#!/bin/bash
NODE_IDS=(6848557 6940382 7085898 7207892 7361139 6641564 7001572 7151530 7121431 7391331 6494831 6494833 7004870 6554567 7095001 7124839 6614527 7424800 7334535 6584825 6524723 7095022 6914724 6854838 6734766 6889978 6559293 7190074 6739606 7280184)
for i in "${!NODE_IDS[@]}"; do
  node_id=${NODE_IDS[$i]}
  log_file="/root/nexus$((i+1)).log"
  /opt/glibc-2.39/lib/ld-linux-x86-64.so.2 \
    --library-path /opt/glibc-2.39/lib:/opt/glibc-2.39/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu \
    /root/.nexus/bin/nexus-network start --node-id "$node_id" > "$log_file" 2>&1 &
done
wait

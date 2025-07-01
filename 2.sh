#!/bin/bash
NODE_IDS=(7781886 7781939 7812415 7812443 7841142 7896861 7926406 7926862 7956993 8103479 8133820 8163511 8163545 8163553 8163624 8222910 8252739)
for i in "${!NODE_IDS[@]}"; do
  node_id=${NODE_IDS[$i]}
  log_file="/root/nexus$((i+1)).log"
  /opt/glibc-2.39/lib/ld-linux-x86-64.so.2 \
    --library-path /opt/glibc-2.39/lib:/opt/glibc-2.39/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu \
    /root/.nexus/bin/nexus-network start --node-id "$node_id" > "$log_file" 2>&1 &
done
wait

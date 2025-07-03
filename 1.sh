#!/bin/bash
#NODE_IDS=(7482750 7512506 7512512 7512952 7542330 7542769 7603513 7603517 7662518 7662919 7692265 7722041 7722066 7722068 7722069 7752269 7752270)
NODE_IDS=(7482750 7512506 7512512)
for i in "${!NODE_IDS[@]}"; do
  node_id=${NODE_IDS[$i]}
  log_file="/root/nexus$((i+1)).log"
  /opt/glibc-2.39/lib/ld-linux-x86-64.so.2 \
    --library-path /opt/glibc-2.39/lib:/opt/glibc-2.39/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu \
    /root/.nexus/bin/nexus-network start --node-id "$node_id" > "$log_file" 2>&1 &
done
wait

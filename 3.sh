#!/bin/bash
NODE_IDS=(8252772 8282648 8342532 8342537 10417821 9759901 8402245 8431896 8431943 8431943 10119726 10178860 10209873 10269189 10299837 10359106 9819806)
for i in "${!NODE_IDS[@]}"; do
  node_id=${NODE_IDS[$i]}
  log_file="/root/nexus$((i+1)).log"
  /opt/glibc-2.39/lib/ld-linux-x86-64.so.2 \
    --library-path /opt/glibc-2.39/lib:/opt/glibc-2.39/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu \
    /root/.nexus/bin/nexus-network start --node-id "$node_id" > "$log_file" 2>&1 &
done
wait

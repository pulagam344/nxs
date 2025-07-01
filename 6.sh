#!/bin/bash
NODE_IDS=(7207892 7251587 7280184 7281788 7286860 7334535 7361139 7391331 7424800 7449070 7471176 7501073 7531066 7535869 7535889 9910320 10387835)
for i in "${!NODE_IDS[@]}"; do
  node_id=${NODE_IDS[$i]}
  log_file="/root/nexus$((i+1)).log"
  /opt/glibc-2.39/lib/ld-linux-x86-64.so.2 \
    --library-path /opt/glibc-2.39/lib:/opt/glibc-2.39/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu \
    /root/.nexus/bin/nexus-network start --node-id "$node_id" > "$log_file" 2>&1 &
done
wait

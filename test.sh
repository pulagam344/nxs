#!/bin/bash

# List of node IDs to run in parallel
NODE_IDS=(12381746 12395950 12255254 12450767 12255255 11810848 12381747 12317724 12201437 12421761 12450770 12052312 12226403 12480157 12421764 12052313 12226406 12052316 11810851 11873265 12052317 12395953 12480159 11873266 12450774 12226409 12450775 11873268 12255262 12317729 12421770 12480161 12480162 12052319 12255263 12381752 12395959 12317731 12381754 11873270 12480166 12317736 12381759 12052322 12480167 12317737 12421776 12255270 12317738 12052323)

# Start infinite loop
while true; do
  echo "Starting all Nexus nodes..."

  # Start each node in background and record PIDs
  PIDS=()
  for NODE_ID in "${NODE_IDS[@]}"; do
    echo "Starting node $NODE_ID"
    /opt/glibc-2.39/lib/ld-linux-x86-64.so.2 \
      --library-path /opt/glibc-2.39/lib:/opt/glibc-2.39/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu \
      /root/.nexus/bin/nexus-network start --node-id "$NODE_ID" &
    
    PIDS+=($!)
  done

  echo "All nodes started. Sleeping for 5 minutes..."
  sleep 3000  # 5 minutes

  echo "Stopping all Nexus nodes..."
  for PID in "${PIDS[@]}"; do
    kill "$PID"
  done

  echo "Cycle complete. Restarting in 5 seconds..."
  sleep 5
done

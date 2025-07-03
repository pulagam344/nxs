#!/bin/bash

# List of node IDs to run in parallel
NODE_IDS=(
  11253230
  10955447
  11191187
  12186828
  12186827
  12215171
  12243975
  11798842
  12364585
)

# Start infinite loop
while true; do
  echo "Starting Nexus nodes..."

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
  sleep 300  # 5 minutes

  echo "Stopping all Nexus nodes..."
  for PID in "${PIDS[@]}"; do
    kill "$PID"
  done

  echo "Cycle complete. Restarting in 5 seconds..."
  sleep 5
done

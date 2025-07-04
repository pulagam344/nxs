#!/bin/bash

# List of node IDs to run in parallel
NODE_IDS=(11874625 12318939 12452373 12256321 12397464 12202649 12053581 12318942 12423209 12227450 12202650 12383072 12318945 12202652 12202653 11812080 11812081 11812082 12423213 11874630 11812085 12452379 11874631 11812086 12423215 12452383 12053585 12481577 12202654 12256325 12452385 12423218 12481580 12452386 12452387 11812089 12053587 12397472 12423221 12481581 12053588 12318952 11874635 12423226 12452389 12318953 12383076 12227456 12452394 12383089 12383090 12053607 12397497 12452404 12452405 12481600 11874645 12202674 12383096 11874646 12256344 11874647 12318970 12256345 12202682) 
# Start infinite loop
while true; do
  echo "Starting 1.03 Nexus nodes..."

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
  sleep 180000  # 3 minutes

  echo "Stopping all Nexus nodes..."
  for PID in "${PIDS[@]}"; do
    kill "$PID"
  done

  echo "Cycle complete. Restarting in 5 seconds..."
  sleep 5
done

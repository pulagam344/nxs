#!/bin/bash

# List of node IDs to run in parallel

#15,16 (T FT)

NODE_IDS=(12751409 12751414 12724392 12641249 12724396 12555772 12447488 12526860 12695098 12555775 12612147 12669124 12447492 12503178 12724404 12526869 12503181 12475866 12751431 12503186 12612151 12526873 12641264 12612154 12475878 12695112 12641267 12695114 12724417 12724419 12612165 12447506 12695118 12555800 12724422 12555802 12695124 12503197 12751451 12447513 12583015 12641278 12503199 12612174 12724429 12475894 12724432 12641283 12751458 12555986 12476109 12751646 12503390 12695254 12447703 12583226 12724583 12583229 12476122 12612351 12724586 12669335 12503408 12476125 12695265 12476126)



# Start infinite loop
while true; do
  echo "Starting 66 Nexus nodes..."

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
  sleep 3000000  # 5 minutes

  echo "Stopping all Nexus nodes..."
  for PID in "${PIDS[@]}"; do
    kill "$PID"
  done

  echo "Cycle complete. Restarting in 5 seconds..."
  sleep 5
done

#!/bin/bash

# Set correct loader path
LOADER="/root/elf/ld-linux-x86-64.so.2"
LIB_PATH="/opt/glibc-2.39/lib:/opt/glibc-2.39/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu"

# List of Nexus node IDs
NODE_IDS=(
  11281138
  11160984
  10776413
  10837017
  10921470
  11132985
)

while true; do
  echo "🔄 Starting all Nexus nodes..."

  # Array to store process IDs
  PIDS=()

  # Start each node
  for NODE_ID in "${NODE_IDS[@]}"; do
    echo "▶️ Starting node $NODE_ID"
    "$LOADER" --library-path "$LIB_PATH" /root/.nexus/bin/nexus-network start --node-id "$NODE_ID" &
    PIDS+=($!)
  done

  echo "⏳ All nodes started. Waiting 5 minutes..."
  sleep 300

  echo "🛑 Stopping all Nexus nodes..."
  for PID in "${PIDS[@]}"; do
    kill "$PID"
  done

  echo "✅ Restart cycle complete. Waiting 5 seconds..."
  sleep 5
done

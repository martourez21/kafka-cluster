#!/bin/bash

# Check if storage is already formatted
if [ ! -f /var/lib/kafka/data/meta.properties ]; then
  echo "Formatting storage..."
  CLUSTER_ID=$(kafka-storage.sh random-uuid)
  kafka-storage.sh format --config /etc/kafka/kafka.properties --cluster-id $CLUSTER_ID
  echo "Formatted with CLUSTER_ID: $CLUSTER_ID"
else
  echo "Storage already formatted. Skipping initialization."
fi

# Start Kafka
exec /etc/confluent/docker/run

# Kafka Cluster Setup for Local Development

A comprehensive Docker-based Kafka cluster designed for local development and testing of event-driven architectures, producer/consumer use cases, and real-time data streaming applications.

## 🚀 Overview

This setup provides a complete Kafka ecosystem with:
- **Single-node Kafka broker** (with KRaft mode - no Zookeeper)
- **Schema Registry** for Avro schema management
- **Kafka Connect** with Elasticsearch connector
- **KSQLDB** for stream processing
- **Kafka UI** for cluster management and monitoring
- **Hybrid connectivity** to both local and Confluent Cloud clusters

## 🛠 Services Included

| Service | Port | Purpose |
|---------|------|---------|
| Kafka Broker | 9092 (external) | Message broker with KRaft |
| Schema Registry | 8081 | Avro schema management |
| Kafka Connect (Local) | 28083 | Connector management for local cluster |
| Kafka Connect (Cloud) | 28084 | Connector management for Confluent Cloud |
| KSQLDB Server | 8088 | Stream processing SQL engine |
| Kafka UI | 28040 | Web-based management interface |

## 📋 Prerequisites

- Docker and Docker Compose
- 4GB+ RAM available
- Confluent Cloud account (optional, for hybrid setup)

## 🚦 Quick Start

1. **Create the Docker network:**
   ```bash
   docker network create kafka-network-02
   ```

2. **Start the cluster:**
   ```bash
   docker-compose up -d
   ```

3. **Verify services are healthy:**
   ```bash
   docker-compose ps
   ```

## 🔧 Configuration

### Local Kafka Broker
- **KRaft Mode**: No Zookeeper required
- **External Access**: `localhost:9092`
- **Internal Access**: `kafka-01:29092`
- **Controller Port**: `29093`

### Schema Registry
- Avro schema management
- Integrated with local Kafka cluster
- REST API on port `8081`

### Kafka Connect Instances

#### Local Connect (`kafka-connect-01`)
- Port: `28083`
- Connects to local Kafka cluster
- Avro converter with local Schema Registry

#### Cloud Connect (`connect-1`)
- Port: `28084`
- Connects to Confluent Cloud
- Includes Elasticsearch connector
- **⚠️ Replace credentials in environment variables**

### KSQLDB
- Stream processing engine
- Integrated with local Kafka and Schema Registry
- REST API on port `8088`

### Kafka UI
- Multi-cluster management
- Access at: `http://localhost:28040`
- Monitors both local and Confluent Cloud clusters

## 🔐 Security Configuration

### For Confluent Cloud Integration

**Replace the following credentials in `connect-1` service:**

```yaml
# Bootstrap servers
CONNECT_BOOTSTRAP_SERVERS: pkc-921jm.us-east__________________:9092

# Schema Registry
CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL: "https://psrc-8kz3w.us______________________________"

# Authentication credentials
CONNECT_SASL_JAAS_CONFIG: 'org.apache.kafka.common.security.plain.PlainLoginModule required username="YOUR_USERNAME" password="YOUR_PASSWORD";'
```

### Steps to Update Credentials:

1. **Get credentials from Confluent Cloud console**
2. **Update the `connect-1` service environment variables:**
   - `CONNECT_BOOTSTRAP_SERVERS`
   - `CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL`
   - `CONNECT_SASL_JAAS_CONFIG`
   - `CONNECT_PRODUCER_SASL_JAAS_CONFIG`
   - `CONNECT_CONSUMER_SASL_JAAS_CONFIG`
   - `CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_BASIC_AUTH_USER_INFO`

3. **Restart the service:**
   ```bash
   docker-compose restart connect-1
   ```

## 🎯 Use Cases

### Ideal for:
- **Producer/Consumer pattern testing**
- **Event-driven architecture development**
- **Schema evolution testing**
- **Kafka Connect connector development**
- **KSQLDB stream processing experiments**
- **Integration testing with real Kafka infrastructure**

### Development Testing:
```bash
# Test producer
kafka-console-producer --broker-list localhost:9092 --topic test-topic

# Test consumer
kafka-console-consumer --bootstrap-server localhost:9092 --topic test-topic --from-beginning
```

## 🧹 Maintenance

### Stop the cluster:
```bash
docker-compose down
```

### Remove volumes (clears all data):
```bash
docker-compose down -v
```

### View logs:
```bash
docker-compose logs [service-name]
```

## 📊 Monitoring

Access **Kafka UI** at `http://localhost:28040` to:
- Monitor topic metrics
- View consumer groups
- Manage connectors
- Inspect schemas
- Monitor both local and cloud clusters

## ⚠️ Important Notes

- **Development Only**: This setup is not production-ready
- **Single Broker**: Runs a single Kafka node (not fault-tolerant)
- **No Security**: Plaintext communication between services
- **Data Persistence**: Kafka data persists in Docker volume `kafka-data`
- **Health Checks**: All services include health checks for reliable startup

## 🔄 Troubleshooting

1. **Port conflicts**: Ensure ports 9092, 8081, 8088, 28040 are available
2. **Network issues**: Verify `kafka-network-02` exists
3. **Connect failures**: Check Confluent Cloud credentials in `connect-1`
4. **Startup order**: Services have dependencies configured for proper startup

## 📚 Learning Resources

- [Kafka Documentation](https://kafka.apache.org/documentation/)
- [Confluent Documentation](https://docs.confluent.io/)
- [KSQLDB Documentation](https://docs.ksqldb.io/)

---

**Happy Event Streaming!** 
# Use official Java runtime as base
FROM eclipse-temurin:17-jdk AS builder

# Copy application JARs
WORKDIR /apps
COPY app1.jar app1.jar
COPY app2.jar app2.jar

# Install Caddy (lightweight reverse proxy)
RUN apt-get update && apt-get install -y caddy && rm -rf /var/lib/apt/lists/*

# Copy Caddy config
COPY Caddyfile /etc/caddy/Caddyfile

# Expose Caddy port
EXPOSE 80

# Start both JARs + Caddy
CMD java -jar app1.jar & \
    java -jar app2.jar & \
    caddy run --config /etc/caddy/Caddyfile --adapter caddyfile

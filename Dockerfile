FROM eclipse-temurin:17-jdk

# Workdir
WORKDIR /apps

# Copy JARs
COPY app1.jar app1.jar
COPY app2.jar app2.jar

# Install Caddy + supervisord
RUN apt-get update && apt-get install -y caddy supervisor && rm -rf /var/lib/apt/lists/*

# Copy configs
COPY Caddyfile /etc/caddy/Caddyfile
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port for Caddy
EXPOSE 80

# Run all apps via supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

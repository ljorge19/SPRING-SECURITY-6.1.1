FROM eclipse-temurin:17-jdk

# Atualiza pacotes e instala o cliente psql
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*

COPY target/auth-0.0.1-SNAPSHOT.jar /app/app.jar
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

ENTRYPOINT ["/app/wait-for-it.sh", "db:5432", "--", "java", "-jar", "/app/app.jar"]
#!/bin/sh

SLEEP=1500
echo "Esperando $SLEEP segundos para o banco iniciar..."
sleep $SLEEP

echo "Iniciando a aplicação..."
java -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar

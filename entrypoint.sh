#!/bin/bash

# Espera até que o Postgres esteja pronto antes de executar o comando principal
/app/wait-for-it.sh db:5432 -- java -jar /app/app.jar

#!/usr/bin/env bash
# wait-for-it.sh

set -e

if [ "$#" -lt 2 ]; then
  echo "Uso: $0 host:porta comando..."
  exit 1
fi

host_port="$1"
shift
cmd="$@"

host=$(echo "$host_port" | cut -d ':' -f 1)
port=$(echo "$host_port" | cut -d ':' -f 2)
port=${port:-5432}

MAX_RETRIES=1000
count=0

first_try=true

until PGPASSWORD="$POSTGRES_PASSWORD" psql -h "$host" -p "$port" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q' 2>/dev/null; do
  count=$((count + 1))
  if [ "$first_try" = true ]; then
    >&2 echo "Banco subindo..."
    first_try=false
  fi
  if [ "$count" -ge "$MAX_RETRIES" ]; then
    >&2 echo "Timeout alcançado: Postgres não ficou disponível após $MAX_RETRIES tentativas."
    exit 1
  fi
  sleep 1
done


>&2 echo "Postgres está UP - executando comando: $cmd"
exec $cmd

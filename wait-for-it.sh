#!/usr/bin/env bash
# wait-for-it.sh

set -e

# Recebe o host:porta e separa
host_port="$1"
shift
cmd="$@"

host=$(echo "$host_port" | cut -d ':' -f 1)
port=$(echo "$host_port" | cut -d ':' -f 2)

# Usa a porta padrão 5432 caso não seja informada
port=${port:-5432}

until PGPASSWORD=password psql -h "$host" -p "$port" -U "postgres" -d "product" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd
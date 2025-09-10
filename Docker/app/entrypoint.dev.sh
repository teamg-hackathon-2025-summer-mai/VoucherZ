#!/bin/sh
set -e

# DB が応答するまで待機
echo "Waiting for database..."
while ! nc -z db 3306; do
  sleep 1
done

echo "Running migrations..."
python manage.py migrate --noinput

if [ -f demo_data.json ]; then
  echo "Loading demo_data.json..."
  python manage.py loaddata demo_data.json
fi

echo "Starting Django dev server..."
exec python manage.py runserver_plus 0.0.0.0:8000
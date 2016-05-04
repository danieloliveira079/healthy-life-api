#!/bin/sh

sleep 20

# Create database
has_db=$(psql -h $DATABASE_HOST -U postgres -lqt | cut -d \| -f 1 | grep -w healthy-api_development | wc -l )

if [ $has_db != 0 ]; then
  echo "Existing database migrate only"
  bundle exec rake db:migrate
else
  echo "Non-Existing database setup"
  bundle exec rake db:setup
fi

bundle exec rails s -p 3000 -b 0.0.0.0

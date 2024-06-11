#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Remove any existing server PID file
rm -f tmp/pids/server.pid

# Please comment next 3 lines below if u r not run first time
# Create the database
bundle exec rails db:create

# Run database migrations
bundle exec rails db:migrate

# Seed the database
bundle exec rails db:seed

# Start the Rails server
bundle exec rails s -p 8080 -b '0.0.0.0'

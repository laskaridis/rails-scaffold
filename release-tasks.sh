#! /bin/bash

echo "== running migrations:"
bundle exec rails db:migrate

echo "== seeding database:"
bundle exec rails db:seed

echo "== clearing cache:"
bundle exec rails r "Rails.cache.clear"

#!/bin/bash

cd /var/www/nayami2/ \
&& git pull \
&& bundle install --path vendor/bundle --without test development \
&& bundle exec rails assets:precompile RAILS_ENV=production 
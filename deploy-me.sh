#!/bin/bash

cd /var/www/nayami2/ \
&& git pull \
&& bundle exec rails assets:precompile RAILS_ENV=production
&& sudo service nginx start \
&& bundle exec rails s -e production

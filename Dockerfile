FROM ruby:2.3.0
MAINTAINER kikyous <kikyous@163.com>

RUN apt-get update && apt-get install -qq -y nodejs nginx libmysqlclient-dev
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf && chown -R www-data:www-data /var/lib/nginx

# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

# Install foreman
RUN gem install foreman

ENV RAILS_ENV production

# Install the latest postgresql lib for pg gem
WORKDIR /app
ONBUILD ADD Gemfile /app/Gemfile
ONBUILD ADD Gemfile.lock /app/Gemfile.lock
ONBUILD RUN bundle install --without development test
ONBUILD ADD . /app

# Add default unicorn config
ADD puma.rb /app/config/puma.rb

# Add default foreman config
ADD Procfile /app/Procfile


CMD bundle exec rake assets:precompile && foreman start -f Procfile

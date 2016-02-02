FROM ruby:2.3.0
MAINTAINER kikyous <kikyous@163.com>

RUN apt-get update && apt-get install -y --no-install-recommends nodejs nginx libmysqlclient-dev && rm -rf /var/lib/apt/lists/* \
        && echo "\ndaemon off;" >> /etc/nginx/nginx.conf && chown -R www-data:www-data /var/lib/nginx

ENV RAILS_ENV production

# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

# Install foreman
RUN gem install foreman

# Add default puma config
ADD puma.rb /app/config/puma.rb

# Add default foreman config
ADD Procfile /app/Procfile

# Install app
WORKDIR /app
ONBUILD COPY ["Gemfile", "Gemfile.lock", "/app/"]
ONBUILD RUN bundle install --without development test --jobs 4
ONBUILD ADD . /app
ONBUILD RUN bundle exec rake assets:precompile 

EXPOSE 80

CMD foreman start -f Procfile

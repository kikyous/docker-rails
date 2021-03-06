FROM ruby:2.3
MAINTAINER kikyous <kikyous@163.com>

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
        && apt-get install -y --no-install-recommends nodejs nginx && rm -rf /var/lib/apt/lists/* \
        && echo "\ndaemon off;" >> /etc/nginx/nginx.conf && chown -R www-data:www-data /var/lib/nginx

RUN wget http://download.redis.io/releases/redis-3.2.7.tar.gz \
        && tar xzf redis-3.2.7.tar.gz \
        && cd redis-3.2.7 \
        && make && make install \
        && cd .. && rm -rf redis*

ENV RAILS_ENV production

# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

# Install foreman
RUN gem install foreman

# Add default config
COPY *.rb /app/config/

# Add default foreman config
ADD Procfile /app/Procfile

# Install app
WORKDIR /app
ONBUILD COPY ["Gemfile", "Gemfile.lock", "/app/"]
ONBUILD RUN bundle install --without development test --jobs 4
ONBUILD ADD . /app

EXPOSE 80

CMD foreman start -f Procfile

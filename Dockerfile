FROM ruby:2.3.1
MAINTAINER kikyous <kikyous@163.com>

RUN apt-get update && apt-get install -y --no-install-recommends nodejs nginx libmysqlclient-dev && rm -rf /var/lib/apt/lists/* \
	&& ln -s $(which nodejs) /usr/bin/node && wget https://npmjs.org/install.sh && chmod +x install.sh && ./install.sh \
        && echo "\ndaemon off;" >> /etc/nginx/nginx.conf && chown -R www-data:www-data /var/lib/nginx

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

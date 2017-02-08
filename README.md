# Dockernize your rails app easiest way
## add Dockerfile

add this Dockerfile to your rails app root

```
FROM kikyous/docker-rails
MAINTAINER someone <someone@mail.com>

RUN mv secrets.yml.example secrets.yml && mv database.yml.example database.yml \
      && bundle exec rake assets:precompile
```

## what's in it
- ruby 2.3
- nginx
- redis 3.2

## Customize Procfile
- add a *Procfile* to you project root

```
web: bundle exec rake db:migrate RAILS_ENV=production && bundle exec puma
nginx: nginx -c /etc/nginx/nginx.conf
redis: redis-server
sidekiq: bundle exec sidekiq RAILS_ENV=production
```

## Customize puma/unicorn config file
- add you config file (puma.rb or unicorn.rb) to /config

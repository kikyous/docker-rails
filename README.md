# Dockernize your rails app easiest way
## add Dockerfile

add this Dockerfile to your rails app root

```
FROM kikyous/docker-rails
MAINTAINER someone <someone@mail.com>

RUN mv secrets.yml.example secrets.yml && mv database.yml.example database.yml \
      && bundle exec rake assets:precompile
```

## build image

`docker build -t someone/my-app .`

## push to docker hub

`docker push someone/my-app`

## run it anywhere
`docker run -i -p 80:80  --name="myapp" someone/my-app`

## what's in it
- ruby 2.3
- nginx

## notice
- add `gem 'puma'` to Gemfile if you use puma
- add `gem 'unicorn-rails'` to Gemfile if you use unicorn

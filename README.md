# Dockernize your rails app easiest way
## add Dockerfile

add this Dockerfile to your rails app root

```
FROM kikyous/docker-nginx-puma
MAINTAINER someone <someone@gmail.com>
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
- puma

## best practice
- you have to add `gem 'puma'` to your Gemfile.
- you can use your own config/puma.rb, but these line is needed.

```
environment 'production'
bind "unix:///tmp/puma.sock"
```

- you can use your own Procfile, but these line is needed.

```
web: bundle exec puma -C config/puma.rb
nginx: nginx -c /etc/nginx/nginx.conf
```
- use env to set database, for example:

```
production:
  adapter: mysql2
  host: <%= ENV['MYSQL_PORT_3306_TCP_ADDR'] %>
  database: <%= ENV['MYSQL_INSTANCE_NAME'] %>
  username: <%= ENV['MYSQL_USERNAME'] %>
  password: <%= ENV['MYSQL_PASSWORD'] %>
```

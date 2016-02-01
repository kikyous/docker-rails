# Dockernize your rails app easiest way
## add Dockerfile

add this Dockerfile to your rails app root

```
FROM kikyous/docker-nginx-puma
MAINTAINER someone <someone@163.com>
EXPOSE 80
```

## build image

`docker build -t someone/my-app .`

## push to docker hub

`docker push somewone/my-app`

## run it anywhere
`docker run -i -p 80:80  --name="myapp" someone/my-app`

## what's in it
- ruby 2.3
- nginx
- puma

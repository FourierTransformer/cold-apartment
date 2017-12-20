# TAGGED APPROPRIATELY!
# can't use the rpm version because i need build tools for lpeg install a
# little later on...
FROM fouriertransformer/docker-openresty:1.11.2.5

MAINTAINER Shakil Thakur <shakil.thakur@gmail.com> # 2016-12-10

# install some rocks
RUN mkdir /app
COPY *.rockspec /app/
# required for luacrypto
RUN apk add --no-cache --virtual .build-deps libressl-dev
RUN /usr/local/openresty/luajit/bin/luarocks build --only-deps /app/*.rockspec

# FINAL SETUP
WORKDIR /app
COPY *.lua /app/
COPY views /app/views
COPY mime.types /app/
COPY nginx.conf /app/

ENTRYPOINT ["/usr/local/openresty/luajit/bin/lapis", "server"]

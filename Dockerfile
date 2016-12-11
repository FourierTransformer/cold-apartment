# TAGGED APPROPRIATELY!
# can't use the rpm version because i need build tools for lpeg install a
# little later on...
FROM openresty/openresty:1.11.2.2-centos

MAINTAINER Shakil Thakur <shakil.thakur@gmail.com> # 2016-12-10

# install some rocks
RUN mkdir /app
COPY *.rockspec /app/
# required for luacrypto
RUN yum install -y openssl-devel
RUN /usr/local/openresty/luajit/bin/luarocks build --only-deps /app/*.rockspec

# FINAL SETUP
WORKDIR /app
COPY *.lua /app/
COPY views /app/views
COPY mime.types /app/
COPY nginx.conf /app/

# just to help automate creating this for prod
RUN mkdir /ssl

ENTRYPOINT ["/usr/local/openresty/luajit/bin/lapis", "server"]
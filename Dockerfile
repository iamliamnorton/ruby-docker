FROM iamliamnorton/alpine
MAINTAINER Liam Norton

ENV RUBY_VER 2.2.3
RUN apk update && apk upgrade \
  && apk add --update gcc libc-dev make openssl-dev ruby zlib-dev readline-dev libxml2-dev libxslt-dev libffi-dev \
  && git clone https://github.com/postmodern/ruby-install /usr/src/ruby-install \
  && cd /usr/src/ruby-install \
  && make install \
  && ruby-install --system ruby $RUBY_VER -- --disable-install-rdoc \
  && apk del ruby \
  && rm -rf /usr/src/* \
  && rm -rf /var/cache/apk/*

ENV BUNDLER_VER 1.10.6
RUN gem install bundler --no-ri --no-rdoc --version "$BUNDLER_VER" \
  && bundle config --global build.nokogiri --use-system-libraries

CMD [ "irb" ]

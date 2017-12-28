FROM ubuntu:xenial

RUN set -eux; \
    apt-get update && \
    apt-get install -yq build-essential curl ruby ruby-dev && \
    gem i bundler --no-ri --no-rdoc
RUN curl -L https://github.com/yowcow/vim-ver/releases/download/v1.0.2/vimver-linux.tar.gz -o /tmp/vimver.tar.gz && \
    tar xzf /tmp/vimver.tar.gz -C /tmp && \
    mv /tmp/vimver /usr/local/bin/vimver

RUN mkdir -p /srv/my-itamae
WORKDIR /srv/my-itamae
COPY . .
RUN make realclean

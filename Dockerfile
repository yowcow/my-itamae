FROM ubuntu:xenial

RUN set -eux; \
    apt-get update && \
    apt-get install -yq build-essential curl ruby ruby-dev && \
    gem i bundler --no-ri --no-rdoc
RUN curl -L https://github.com/yowcow/vim-ver/releases/download/v1.0.0/linux-amd64.tar.gz -o /tmp/vim-ver.tar.gz && \
    tar xzf /tmp/vim-ver.tar.gz -C /tmp && \
    mv /tmp/_build/linux-amd64/vim-ver /usr/local/bin/vim-ver

RUN mkdir -p /srv/my-itamae
WORKDIR /srv/my-itamae
COPY . .
RUN make realclean

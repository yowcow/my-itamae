# libxslt1-dev may be libxslt-dev

%w{
  autoconf
  automake
  build-essential
  ca-certificates
  clang
  cmake
  cronolog
  curl
  finger
  gawk
  g++
  htop
  libdb-dev
  libevent-dev
  libfontconfig1-dev
  libicu-dev
  libssl-dev
  libtool
  libuv1-dev
  libxml2-dev
  libxslt1-dev
  linux-headers-generic
  linux-image-generic
  linux-tools-generic
  lynx
  netbase
  nghttp2-client
  pkg-config
  software-properties-common
  tmpreaper
  traceroute
  tzdata
  unzip
  zlib1g-dev
}.each do |pkg|
  package pkg do
    action :install
  end
end

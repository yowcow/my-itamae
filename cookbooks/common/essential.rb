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
  libdb-dev
  libevent-dev
  libicu-dev
  libssl-dev
  libtool
  linux-headers-generic
  linux-image-generic
  pkg-config
  software-properties-common
  traceroute
  tzdata
  unzip
}.each do |pkg|
  package pkg do
    action :install
  end
end

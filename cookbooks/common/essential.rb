%w{
  build-essential
  clang
  cmake
  cronolog
  curl
  finger
  gawk
  libdb-dev
  libevent-dev
  libicu-dev
  libssl-dev
  linux-headers-generic
  linux-image-generic
  mysql-client
  pkg-config
  software-properties-common
  tzdata
}.each do |pkg|
  package pkg do
    action :install
  end
end

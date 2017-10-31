%w{
  build-essential
  clang
  cronolog
  curl
  finger
  gawk
  libdb-dev
  libevent-dev
  libicu-dev
  libssl-dev
  pkg-config
  software-properties-common
}.each do |pkg|
  package pkg do
    action :install
  end
end

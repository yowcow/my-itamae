%w{
  build-essential
  clang
  cronolog
  curl
  finger
  libdb-dev
  libevent-dev
  libicu-dev
  libssl-dev
  pkg-config
}.each do |pkg|
  package pkg do
    action :install
  end
end

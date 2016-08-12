%w{
  build-essential
  clang
  cronolog
  curl
  libdb-dev
  libevent-dev
  libssl-dev
  realpath
}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{
  build-essential
  clang
  cronolog
  curl
  exuberant-ctags
  libdb-dev
  libevent-dev
  libicu-dev
  libssl-dev
}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{
  build-essential
  clang
  cronolog
  curl
  libssl-dev
}.each do |pkg|
  package pkg do
    action :install
  end
end

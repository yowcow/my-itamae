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
  linux-headers-generic
  linux-image-generic
  pkg-config
  software-properties-common
  tzdata
}.each do |pkg|
  package pkg do
    action :install
  end
end

execute "set /etc/timezone" do
  command <<-CMD
    echo "Asia/Tokyo" > /etc/timezone
  CMD
end

template "/etc/selinux/config" do
  owner "root"
  action :create
  mode "0644"
  source "templates/etc/selinux/config.erb"
end

%w{
  epel-release
}.each do |pkg|
  package pkg
end

%w{
  bind-utils
  cronolog
  curl
  emacs
  git
  jq
  make
  patch
  procps-ng
  rsync
  screen
  sqlite
  sysstat
  tmux
  tree
  vim-common
  vim-enhanced
  vim-minimal
  whois
  zip
  zsh
}.each do |pkg|
  package pkg
end

%w{
  expat-devel
  freetype-devel
  gcc
  giflib-devel
  libjpeg-turbo-devel
  libpng12-devel
  libtiff-devel
  libxml2-devel
}.each do |pkg|
  package pkg
end

%w{
  ntp
  ntpdate
  ntp-doc
}.each do |pkg|
  package pkg
end

service "ntpd" do
  action [:enable, :stop, :start]
end

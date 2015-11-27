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

%w{
  apt-file
  build-essential
  clang
  cronolog
  curl
  default-jre-headless
  git
  jq
  libssl-dev
  ntp
  redis-server
  screen
  sqlite3
  supervisor
  tmux
  tree
  valgrind
  vim
  whois
  zip
  zsh
}.each do |pkg|
  package pkg do
    action :install
  end
end

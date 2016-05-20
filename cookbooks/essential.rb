%w{
  apt-file
  build-essential
  clang
  cronolog
  curl
  git
  jq
  libssl-dev
  ntp
  screen
  sqlite3
  supervisor
  sysstat
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

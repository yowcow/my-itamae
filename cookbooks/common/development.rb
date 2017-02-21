%w{
  apt-file
  git
  jq
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
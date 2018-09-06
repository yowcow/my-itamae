%w{
  apache2-utils
  dstat
  jq
  mysql-client
  mysql-common
  ntp
  screen
  sqlite3
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

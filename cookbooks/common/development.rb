%w{
  apache2-utils
  dstat
  imagemagick
  jq
  ntp
  postgresql-client
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

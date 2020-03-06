%w{
  apache2-utils
  bash
  dstat
  imagemagick
  jq
  postgresql-client
  screen
  sqlite3
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

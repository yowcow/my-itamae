%w{
  build-essential
  cronolog
  curl
  default-jre-headless
  git
  ntp
  redis-server
  screen
  sqlite3
  supervisor
  tmux
  tree
  vim
  whois
  zip
  zsh
}.each do |pkg|
  package pkg do
    action :install
  end
end

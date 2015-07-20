%w{
  build-essential
  cronolog
  curl
  git
  ntp
  screen
  sqlite3
  supervisor
  tree
  vim
  zip
  zsh
}.each do |pkg|
  package pkg do
    action :install
  end
end

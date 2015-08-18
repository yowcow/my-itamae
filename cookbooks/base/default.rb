%w{
  build-essential
  cronolog
  curl
  default-jre-headless
  git
  mysql-server
  ntp
  redis-server
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

template "/etc/environment" do
  source "templates/etc/environment.erb"
end

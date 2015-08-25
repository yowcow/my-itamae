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

template "/home/vagrant/.gitconfig" do
  user "vagrant"
  source "templates/home/vagrant/gitconfig.erb"
  not_if "test -e /home/vagrant/.gitconfig"
end

template "/home/#{node[:common][:user]}/.gitconfig" do
  user node[:common][:user]
  source "templates/home/vagrant/gitconfig.erb"
  not_if "test -e /home/vagrant/.gitconfig"
end

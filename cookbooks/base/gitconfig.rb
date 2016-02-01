template "/home/#{node[:common][:user]}/.gitconfig" do
  user node[:common][:user]
  source "templates/home/gitconfig.erb"
  not_if "test -e /home/#{node[:common][:user]}/.gitconfig"
end

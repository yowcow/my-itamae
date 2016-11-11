node[:anyenv][:user] = ENV["CIRCLECI"] ? "ubuntu" : "root"

directory "/var/log/my_tmp" do
  action :create
  mode "0777"
end

include_recipe "../../cookbooks/anyenv/default.rb"
include_recipe "../../cookbooks/anyenv/ndenv.rb"
include_recipe "../../cookbooks/anyenv/plenv.rb"
include_recipe "../../cookbooks/mysql/default.rb"

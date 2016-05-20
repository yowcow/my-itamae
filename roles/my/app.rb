node[:anyenv][:user] = ENV["CIRCLECI"] ? "ubuntu" : "root"

include_recipe "../../cookbooks/anyenv/default.rb"
include_recipe "../../cookbooks/anyenv/ndenv.rb"
include_recipe "../../cookbooks/anyenv/plenv.rb"

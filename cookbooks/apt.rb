%w{
  apt-file
  apt-transport-https
}.each do |pkg|
  package pkg
end

execute "Copy original sources.list" do
  command <<-CMD
    cp /etc/apt/sources.list /etc/apt/sources.list.old
  CMD
  not_if "test -f /etc/apt/sources.list.old"
end

include_recipe "apt/default.rb"

node[:apt][:repos][ENV["ENVNAME"]].each do |repo|
  include_recipe "apt/#{repo}.rb"
end

execute "Update apt" do
  command <<-CMD
    apt-get update -qq
  CMD
end

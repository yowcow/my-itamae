package "ruby-dev"

gem_package "travis" do
  action :install
  version node[:travis][:version]
end

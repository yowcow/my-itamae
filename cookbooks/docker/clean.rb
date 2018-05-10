version = node[:docker][:compose][:version]

directory "/usr/local/docker-clean-#{version}/bin" do
  action :create
end

http_request "/usr/local/docker-clean-#{version}/bin/docker-clean" do
  url "https://raw.githubusercontent.com/ZZROTDesign/docker-clean/v2.0.4/docker-clean"
  mode "0755"
  not_if "test -e /usr/local/docker-clean-#{version}/bin/docker-clean"
end

link "/usr/local/bin/docker-clean" do
  to "/usr/local/docker-clean-#{version}/bin/docker-clean"
  force true
end

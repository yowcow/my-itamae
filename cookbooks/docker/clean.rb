version = node[:docker][:clean][:version]
archive = "docker-clean-v#{version}.tar.gz"
url = "https://github.com/ZZROTDesign/docker-clean/archive/v#{version}.tar.gz"
dir = "/usr/local/docker-clean-#{version}"

http_request "/tmp/#{archive}" do
  url url
  mode "0644"
  not_if "test -e /tmp/#{archive} || test -d #{dir}"
end

execute "Unarchive /tmp/#{archive}" do
  command <<-CMD
    tar xzf /tmp/#{archive} -C /usr/local
    chmod 755 #{dir}
  CMD
  not_if "test -d #{dir}"
end

link "/usr/local/bin/docker-clean" do
  to "/usr/local/docker-clean-#{version}/docker-clean"
  force true
end

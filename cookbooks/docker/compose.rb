version      = node[:docker][:compose][:version]
version_file = "/usr/local/src/docker-compose-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/usr/local/bin/docker-compose" do
    url "https://github.com/docker/compose/releases/download/#{version}/docker-compose-Linux-x86_64"
    mode "0755"
  end

  file version_file do
    content version
    mode "0644"
  end
end

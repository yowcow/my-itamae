version = node[:goreplay][:version]
archive = "gor_#{version}_x64.tar.gz"
url = "https://github.com/buger/goreplay/releases/download/v#{version}/#{archive}"
targetdir = "/usr/local/gor-#{version}"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -f #{targetdir}/goreplay || test -f /tmp/#{archive}"
end

directory targetdir do
  mode "0755"
  action :create
end

execute "Unarchive /tmp/#{archive}" do
  command <<-CMD
    tar xzf /tmp/#{archive} -C #{targetdir}
  CMD
  not_if "test -f #{targetdir}/goreplay"
end

link "/usr/local/bin/goreplay" do
  to "#{targetdir}/goreplay"
  force true
end

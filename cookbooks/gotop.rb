version = node[:gotop][:version]
archive = "gotop_#{version}_linux_amd64.tgz"
url = "https://github.com/cjbassi/gotop/releases/download/#{version}/#{archive}"
targetdir = "/usr/local/gotop-#{version}"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -f #{targetdir}/gotop || test -f /tmp/#{archive}"
end

directory targetdir do
  mode "0755"
  action :create
end

execute "Unarchive /tmp/#{archive}" do
  command <<-CMD
    tar xzf /tmp/#{archive} -C #{targetdir}
  CMD
  not_if "test -f #{targetdir}/gotop"
end

link "/usr/local/bin/gotop" do
  to "#{targetdir}/gotop"
end

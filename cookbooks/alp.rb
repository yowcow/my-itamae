version = node[:alp][:version]
archive = "alp_#{version}_linux_amd64.zip"
url = "https://github.com/tkuchiki/alp/releases/download/v#{version}/alp_linux_amd64.zip"
targetdir = "/usr/local/alp-#{version}"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -f #{targetdir}/alp || test -f /tmp/#{archive}"
end

directory targetdir do
  mode "0755"
  action :create
end

execute "Unarchive /tmp/#{archive}" do
  command <<-CMD
    unzip /tmp/#{archive} -d #{targetdir}
  CMD
  not_if "test -f #{targetdir}/alp"
end

link "/usr/local/bin/alp" do
  to "#{targetdir}/alp"
  force true
end

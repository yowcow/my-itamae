version = node[:alp][:version]

archive      = "alp_#{version}_linux_amd64.zip"
url          = "https://github.com/tkuchiki/alp/releases/download/v#{version}/alp_linux_amd64.zip"
version_file = "/usr/local/src/alp-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/tmp/#{archive}" do
    url url
    not_if "test -f /tmp/#{archive}"
  end

  execute "Unarchive /tmp/#{archive}" do
    command <<-CMD
      unzip /tmp/#{archive} -d /tmp && \
      mv /tmp/alp /usr/local/bin/alp
    CMD
  end

  file "/usr/local/bin/alp" do
    owner "root"
    group "root"
    mode "0755"
  end

  file version_file do
    content version
    mode "0644"
  end
end

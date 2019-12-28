version      = node[:ripgrep][:version]
version_file = "/usr/local/src/ripgrep-version"

deb = "ripgrep_#{version}_amd64.deb"
url = "https://github.com/BurntSushi/ripgrep/releases/download/#{version}/#{deb}"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/tmp/#{deb}" do
    url url
    not_if "test -f /tmp/#{deb}"
  end

  execute "install #{deb}" do
    command <<-CMD
      dpkg -i /tmp/#{deb}
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end

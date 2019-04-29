version = node[:ripgrep][:version]

deb = "ripgrep_#{version}_amd64.deb"
url = "https://github.com/BurntSushi/ripgrep/releases/download/#{version}/#{deb}"

current = `(which rg 1>/dev/null && rg -V || true) | cut -d" " -f2 | tr -d "\n"`

if current != version then
  http_request "/tmp/#{deb}" do
    url url
    not_if "test -f /tmp/#{deb}"
  end

  execute "install #{deb}" do
    command <<-CMD
      dpkg -i /tmp/#{deb}
    CMD
  end
end

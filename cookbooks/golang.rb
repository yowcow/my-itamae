version = node[:golang][:version]

archive = "go#{version}.linux-amd64.tar.gz"
url     = "https://storage.googleapis.com/golang/#{archive}"
profile = "/etc/profile.d/golang.sh"
version_file = "/usr/local/src/golang-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  execute "Remove previously installed version if exists" do
    command <<-CMD
      rm -rf /usr/local/go
    CMD
  end

  http_request "/tmp/#{archive}" do
    url url
  end

  execute "Install to golang-#{version}" do
    command <<-CMD
      tar xzf /tmp/#{archive} -C /usr/local
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end

file profile do
  content <<-END
PATH=/usr/local/go/bin:$PATH
  END
  mode "0644"
end

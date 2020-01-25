version      = node[:golang][:version]
version_file = "/usr/local/src/golang-version"

prefix  = "/usr/local/go"
archive = "go#{version}.linux-amd64.tar.gz"
url     = "https://storage.googleapis.com/golang/#{archive}"
profile = "/etc/profile.d/golang.sh"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  execute "Remove previously installed version if exists" do
    command <<-CMD
      rm -rf #{prefix}
    CMD
  end

  http_request "/tmp/#{archive}" do
    url url
    not_if "test -f /tmp/#{archive}"
  end

  execute "Install to golang-#{version}" do
    command <<-CMD
      mkdir -p #{prefix} && \
      tar xzf /tmp/#{archive} -C #{prefix} --strip-components 1
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end

file profile do
  content <<-END
PATH=#{prefix}/bin:$PATH
  END
  mode "0644"
end

version = node[:golang][:version]

archive = "go#{version}.linux-amd64.tar.gz"
url     = "https://storage.googleapis.com/golang/#{archive}"

target  = "/usr/local/go-#{version}"
profile = "/etc/profile.d/golangrc.sh"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{target} || test -f /tmp/#{archive}"
end

execute "Install to #{target}" do
  command <<-CMD
    tar xzf /tmp/#{archive} -C /tmp && \
    mv /tmp/go #{target}
  CMD
  not_if "test -d #{target}"
end


execute "Install to #{profile}" do
  command <<-CMD
    echo 'export GOROOT=/usr/local/go-#{version}' > #{profile}
    echo PATH=#{target}/bin:#{'\$PATH'} >> #{profile}
  CMD
end

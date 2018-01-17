version = node[:nodejs][:version]

archive = "node-#{version}-linux-x64.tar.xz"
url     = "https://nodejs.org/dist/#{version}/#{archive}"

target  = "/usr/local/node-#{version}-linux-x64"
profile = "/usr/local/etc/profile.d/nodejsrc.sh"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{target} || test -f /tmp/#{archive}"
end

execute "Install to #{target}" do
  command <<-CMD
    cd /tmp && \
    tar xf #{archive} && \
    mv node-#{version}-linux-x64 /usr/local
  CMD
  not_if "test -d #{target}"
end

execute "Install #{profile}" do
  command <<-CMD
    echo PATH=#{target}/bin:#{'\$PATH'} > #{profile}
  CMD
end

%w{
  npm
  npm-check-updates
}.each do |mod|
  execute "Install #{mod}" do
    command <<-CMD
      . #{profile}
      npm i -g #{mod}
    CMD
  end
end

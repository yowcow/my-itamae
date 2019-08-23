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
    chown -R root:root #{target}
  CMD
  not_if "test -d #{target}"
end

file profile do
  content <<-CONTENT
PATH=#{target}/bin:$PATH
  CONTENT
  mode "0644"
end

%w{
  intelephense
  javascript-typescript-langserver
  neovim
  npm
  npm-check-updates
  typescript-language-server
}.each do |mod|
  execute "Install #{mod}" do
    command <<-CMD
      . #{profile}
      npm i -g #{mod}
    CMD
  end
end

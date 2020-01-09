version      = node[:nodejs][:version]
version_file = "/usr/local/src/nodejs-version"

prefix  = "/usr/local/nodejs"
archive = "node-#{version}-linux-x64.tar.xz"
url     = "https://nodejs.org/dist/#{version}/#{archive}"
profile = "/etc/profile.d/nodejs.sh"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  execute "Remove previously installed version if exists" do
    command <<-CMD
      rm -rf #{prefix}
    CMD
  end

  http_request "/tmp/#{archive}" do
    url url
  end

  execute "Install to #{prefix}" do
    command <<-CMD
      cd /tmp && \
      tar xf #{archive} && \
      mv node-#{version}-linux-x64 #{prefix}
      chown -R root:root #{prefix}
    CMD
  end

  file version_file do
    content version
    mode "0644"
  end
end

file profile do
  content <<-CONTENT
PATH=#{prefix}/bin:$PATH
  CONTENT
  mode "0644"
end

%w{
  intelephense
  javascript-typescript-langserver
  neovim
  npm
  npm-check-updates
  typescript
  typescript-language-server
}.each do |mod|
  execute "Install #{mod}" do
    command <<-CMD
      . #{profile}
      npm i -g #{mod}
    CMD
  end
end

%w{
  libevent-dev
  libncurses5-dev
}.each do |pkg|
  package pkg
end

version = node[:tmux][:version]

archive = "tmux-#{version}.tar.gz"
url     = "https://github.com/tmux/tmux/releases/download/#{version}/#{archive}"
target  = "/usr/local"
version_file = "/usr/local/src/tmux-version"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != version then
  http_request "/tmp/#{archive}" do
    url url
  end

  execute "Unarchive #{archive}" do
    command <<-CMD
      tar zxf /tmp/#{archive} -C /tmp
    CMD
  end

  execute "Install to #{target}" do
    command <<-CMD
      cd /tmp/tmux-#{version} && \
      ./configure --prefix #{target} && \
      make && make install
    CMD
    not_if "test -d #{target}"
  end

  file version_file do
    content version
    mode "0644"
  end
end

%w{
  libevent-dev
  libncurses5-dev
}.each do |pkg|
  package pkg
end

version = node[:tmux][:version]

archive = "tmux-#{version}.tar.gz"
url     = "https://github.com/tmux/tmux/releases/download/#{version}/#{archive}"

target  = "/usr/local/tmux-#{version}"
profile = "/etc/profile.d/tmux.sh"

http_request "/tmp/#{archive}" do
  url url
  not_if "test -d #{target} || test -f /tmp/#{archive}"
end

execute "Unarchive #{archive}" do
  command <<-CMD
    tar zxf /tmp/#{archive} -C /tmp
  CMD
  not_if "test -d #{target}"
end

execute "Install to #{target}" do
  command <<-CMD
    cd /tmp/tmux-#{version} && \
    ./configure --prefix #{target} && \
    make && make install
  CMD
  not_if "test -d #{target}"
end

execute "Install #{profile}" do
  command <<-CMD
    echo PATH=#{target}/bin:#{'\$PATH'} > #{profile}
  CMD
  not_if "test -f #{profile}"
end

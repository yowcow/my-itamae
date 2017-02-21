%w{
  libevent-dev
  libncurses5-dev
}.each do |pkg|
  package pkg
end

http_request "/tmp/tmux-#{node[:tmux][:version]}.tar.gz" do
  url "https://github.com/tmux/tmux/releases/download/#{node[:tmux][:version]}/tmux-#{node[:tmux][:version]}.tar.gz"
  not_if "test -d /usr/local/tmux-#{node[:tmux][:version]}"
end

execute "Unarchive tmux-#{node[:tmux][:version]}.tar.gz" do
  command <<-CMD
    cd /tmp && \
    tar zxf tmux-#{node[:tmux][:version]}.tar.gz
  CMD
  not_if "test -d /usr/local/tmux-#{node[:tmux][:version]}"
end

execute "Make and install tmux-#{node[:tmux][:version]}" do
  command <<-CMD
    cd /tmp/tmux-#{node[:tmux][:version]} && \
    ./configure --prefix /usr/local/tmux-#{node[:tmux][:version]} && \
    make && make install
  CMD
  not_if "test -d /usr/local/tmux-#{node[:tmux][:version]}"
end

link "/usr/local/bin/tmux" do
  to "/usr/local/tmux-#{node[:tmux][:version]}/bin/tmux"
end

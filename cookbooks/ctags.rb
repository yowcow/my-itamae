http_request "/tmp/ctags-#{node[:ctags][:version]}.tar.gz" do
  url "http://prdownloads.sourceforge.net/ctags/ctags-#{node[:ctags][:version]}.tar.gz"
  not_if "test -d /usr/local/ctags-#{node[:ctags][:version]}"
end

execute "Unarchive ctags-#{node[:ctags][:version]}.tar.gz" do
  command <<-CMD
    cd /tmp && \
    tar xzf ctags-#{node[:ctags][:version]}.tar.gz
  CMD
  not_if "test -d /usr/local/ctags-#{node[:ctags][:version]}"
end

execute "Make and install ctags-#{node[:ctags][:version]}" do
  command <<-CMD
    cd /tmp/ctags-#{node[:ctags][:version]} && \
    ./configure --prefix /usr/local/ctags-#{node[:ctags][:version]} && \
    make && make install
  CMD
  not_if "test -d /usr/local/ctags-#{node[:ctags][:version]}"
end

template "/etc/profile.d/ctags.sh" do
  action :create
  source "ctags/templates/ctags.erb"
  mode "0644"
  variables(version: node[:ctags][:version])
end

template "/etc/profile.d/erlangrc.sh" do
  action :create
  source "erlang/templates/erlangrc.erb"
  mode "0644"
  variables(version: node[:erlang][:version])
end

http_request "/var/tmp/otp_src_#{node[:erlang][:version]}.tar.gz" do
  url "http://erlang.org/download/otp_src_#{node[:erlang][:version]}.tar.gz"
  not_if "test -d /usr/local/erlang-#{node[:erlang][:version]}"
end

execute "Extract Erlang #{node[:erlang][:version]}" do
  command <<-CMD
    cd /var/tmp && \
    tar xzf otp_src_#{node[:erlang][:version]}.tar.gz
  CMD
  not_if "test -d /usr/local/erlang-#{node[:erlang][:version]}"
end

execute "Install Erlang #{node[:erlang][:version]}" do
  command <<-CMD
    cd /var/tmp/otp_src_#{node[:erlang][:version]} && \
    ./configure --prefix=/usr/local/erlang-#{node[:erlang][:version]} && \
    make && make install
  CMD
  not_if "test -d /usr/local/erlang-#{node[:erlang][:version]}"
end

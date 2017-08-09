include_recipe "./ctags.rb"
include_recipe "./lua.rb"

http_request "/var/tmp/vim-#{node[:vim][:version]}.tar.gz" do
  url "https://github.com/vim/vim/archive/v#{node[:vim][:version]}.tar.gz"
  not_if "test -f /var/tmp/vim-#{node[:vim][:version]}.tar.gz"
end

execute "Extract Vim #{node[:vim][:version]}" do
  command <<-CMD
    cd /var/tmp &&
    tar xzf vim-#{node[:vim][:version]}.tar.gz
  CMD
  not_if "test -d /var/tmp/vim-#{node[:vim][:version]}"
end

execute "Install Vim #{node[:vim][:version]}" do
  command <<-CMD
    cd /var/tmp/vim-#{node[:vim][:version]}/src \
    && ./configure \
      --prefix=/usr/local/vim-#{node[:vim][:version]} \
      --enable-fail-if-missing \
      --enable-luainterp \
      --enable-multibyte \
      --enable-terminal \
      --with-lua-prefix=/usr/local \
    && make && make install
  CMD
  not_if "test -d /usr/local/vim-#{node[:vim][:version]}"
end

template "/etc/profile.d/vim.sh" do
  action :create
  source "vim/templates/vim.erb"
  mode "0644"
  variables(version: node[:vim][:version])
end

git "/tmp/vim" do
  repository "https://github.com/vim/vim.git"
  action :sync
end

execute "Clean previous build" do
  command <<-CMD
    cd /tmp/vim/src && \
    make distclean
  CMD
  not_if "test ! -e /tmp/vim/src/auto/config.cache"
end

execute "Install vim" do
  command <<-CMD
    cd /tmp/vim/src && \
    make && make install
  CMD
  not_if "test -e /usr/local/bin/vim"
end

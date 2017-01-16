git "/tmp/vim" do
  repository "https://github.com/vim/vim.git"
  action :sync
end

execute "Install vim" do
  command <<-CMD
    cd /tmp/vim/src && \
    make distclean && make && make install
  CMD
  not_if "test -e /usr/local/bin/vim"
end

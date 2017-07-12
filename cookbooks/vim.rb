include_recipe "./ctags.rb"
include_recipe "./lua.rb"

git "/var/tmp/vim" do
  repository "https://github.com/vim/vim.git"
  action :sync
end

execute "Clean previous build" do
  command <<-CMD
    cd /var/tmp/vim/src && \
    make distclean
  CMD
  not_if "test ! -e /var/tmp/vim/src/auto/config.cache"
end

execute "Install vim" do
  command <<-CMD
    cd /var/tmp/vim/src \
    && ./configure \
      --enable-fail-if-missing \
      --enable-luainterp \
      --enable-multibyte \
      --with-lua-prefix=/usr/local \
    && make && make install
  CMD
  not_if 'cd /var/tmp/vim && test "${$(git tag | tail -n1): -3}" -eq "${$(vim --version | grep "Included patches" | head -n1): -3}"'
end

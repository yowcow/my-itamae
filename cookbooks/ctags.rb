http_request "/tmp/ctags-5.8.tar.gz" do
  url "http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz"
  not_if "test -e /tmp/ctags-5.8.tar.gz"
end

execute "Extract ctags tarball" do
  command <<-CMD
    cd /tmp && \
    tar xzf ctags-5.8.tar.gz
  CMD
  not_if "test -d /tmp/ctags-5.8"
end

execute "Compile and install ctags" do
  command <<-CMD
    cd /tmp/ctags-5.8 && \
    ./configure --prefix=/usr/local && \
    make && make install
  CMD
  not_if "test -e /usr/local/bin/ctags"
end

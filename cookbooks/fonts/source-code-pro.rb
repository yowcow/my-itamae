sourceurl  = "https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.tar.gz"
targetfile = "/usr/local/share/fonts/source-code-pro.tar.gz"
targetdir  = "/usr/local/share/fonts/source-code-pro"

execute "Download tarball" do
  command <<-CMD
    curl -L #{sourceurl} -o #{targetfile}
  CMD
  not_if "test -e #{targetfile}"
end

execute "Unarchive tarball" do
  command <<-CMD
    mkdir -p #{targetdir} && \
    tar xzf #{targetfile} -C #{targetdir}
  CMD
  not_if "test -e #{targetdir}"
end

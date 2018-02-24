ro_version  = node[:font]["source-code-pro"]["ro-version"]
it_version  = node[:font]["source-code-pro"]["it-version"]
sourceurl  = "https://github.com/adobe-fonts/source-code-pro/archive/#{ro_version}-ro/#{it_version}-it.tar.gz"
targetfile = "/usr/local/share/fonts/source-code-pro-#{ro_version}-#{it_version}.tar.gz"
targetdir  = "/usr/local/share/fonts/source-code-pro"

http_request targetfile do
  url sourceurl
  not_if "test -e #{targetfile}"
end

execute "Unarchive #{targetfile} to #{targetdir}" do
  command <<-CMD
    mkdir -p #{targetdir} && \
    tar xzf #{targetfile} -C #{targetdir}
  CMD
  not_if "test -e #{targetdir}"
end

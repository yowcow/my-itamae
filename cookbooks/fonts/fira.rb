version = node[:font][:fira][:version]

sourceurl  = "https://github.com/mozilla/Fira/archive/#{version}.tar.gz"
targetfile = "/usr/local/share/fonts/fira-v#{version}.tar.gz"
targetdir  = "/usr/local/share/fonts/fira-v#{version}"

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

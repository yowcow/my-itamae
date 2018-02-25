version = node[:font][:hack][:version]
sourceurl  = "https://github.com/source-foundry/Hack/releases/download/v#{version}/Hack-v#{version}-ttf.zip"
targetfile = "/usr/local/share/fonts/Hack-v#{version}-ttf.zip"
targetdir  = "/usr/local/share/fonts/Hack-v#{version}"

http_request targetfile do
  url sourceurl
  not_if "test -e #{targetfile}"
end

execute "Unarchive #{targetfile} to #{targetdir}" do
  command <<-CMD
    unzip #{targetfile} -d #{targetdir}
  CMD
  not_if "test -e #{targetdir}"
end

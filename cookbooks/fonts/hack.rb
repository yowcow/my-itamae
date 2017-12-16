sourceurl  = "https://github.com/source-foundry/Hack/releases/download/v3.000/Hack-v3.000-ttf.zip"
targetfile = "/usr/local/share/fonts/Hack-v3.000-ttf.zip"
targetdir  = "/usr/local/share/fonts/Hack"

execute "Download" do
  command <<-CMD
    curl -L #{sourceurl} -o #{targetfile}
  CMD
  not_if "test -e #{targetfile}"
end

execute "Unarchive" do
  command <<-CMD
    unzip #{targetfile} -d #{targetdir}
  CMD
  not_if "test -e #{targetdir}"
end

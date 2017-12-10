sourceurl  = "https://github.com/RedHatBrand/Overpass/releases/download/3.0.2/overpass-desktop-fonts.zip"
targetfile = "/usr/local/share/fonts/overpass-desktop-fonts.zip"
targetdir  = "/usr/local/share/fonts/overpass-desktop-fonts"

execute "Download zip" do
  command <<-CMD
    curl -L #{sourceurl} -o #{targetfile}
  CMD
  not_if "test -e #{targetfile}"
end

execute "Unzip" do
  command <<-CMD
    unzip #{targetfile} -d #{targetdir}
  CMD
  not_if "test -e #{targetdir}"
end

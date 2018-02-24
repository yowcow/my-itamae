version    = node[:font][:overpass][:version]
sourceurl  = "https://github.com/RedHatBrand/Overpass/releases/download/#{version}/overpass-desktop-fonts.zip"
targetfile = "/usr/local/share/fonts/overpass-desktop-fonts-v#{version}.zip"
targetdir  = "/usr/local/share/fonts/overpass-desktop-fonts"

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

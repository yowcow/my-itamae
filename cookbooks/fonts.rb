include_recipe "fonts/source-code-pro.rb"
include_recipe "fonts/overpass.rb"

execute "fc-cache" do
  command <<-CMD
    fc-cache -f -v
  CMD
end

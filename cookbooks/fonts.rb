include_recipe "fonts/fira.rb"
include_recipe "fonts/hack.rb"
include_recipe "fonts/overpass.rb"
include_recipe "fonts/source-code-pro.rb"

execute "fc-cache" do
  command <<-CMD
    fc-cache -f -v
  CMD
end

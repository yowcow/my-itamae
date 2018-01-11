include_recipe "./base.rb"

include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"

execute "add vagrant user to docker group" do
  command <<-CMD
    usermod -a -G docker vagrant
  CMD
end

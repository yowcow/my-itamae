include_recipe "./base.rb"

include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"
include_recipe "../cookbooks/rkt.rb"
include_recipe "../cookbooks/weechat.rb"

execute "add vagrant user to docker group" do
  command <<-CMD
    usermod -a -G docker vagrant
  CMD
end

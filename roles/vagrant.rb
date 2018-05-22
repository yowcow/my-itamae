include_recipe "./base.rb"

include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/clean.rb"
include_recipe "../cookbooks/docker/compose.rb"
include_recipe "../cookbooks/google-cloud-sdk.rb"
include_recipe "../cookbooks/php.rb"
include_recipe "../cookbooks/php/composer.rb"
include_recipe "../cookbooks/rkt.rb"
include_recipe "../cookbooks/snappy.rb"
include_recipe "../cookbooks/weechat.rb"
include_recipe "../cookbooks/helloworld.rb"

execute "add vagrant user to docker group" do
  command <<-CMD
    usermod -a -G docker vagrant
  CMD
end

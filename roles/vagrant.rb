include_recipe "./base.rb"

include_recipe "../cookbooks/chromium.rb"
include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"
include_recipe "../cookbooks/google-cloud-sdk.rb"
include_recipe "../cookbooks/php.rb"
include_recipe "../cookbooks/php/composer.rb"
include_recipe "../cookbooks/rkt.rb"
#include_recipe "../cookbooks/snappy.rb"
include_recipe "../cookbooks/timesyncd.rb"
include_recipe "../cookbooks/timezone.rb"
include_recipe "../cookbooks/weechat.rb"

include_recipe "../cookbooks/protobuf.rb"
include_recipe "../cookbooks/grpc.rb"

execute "add vagrant user to docker group" do
  command <<-CMD
    usermod -a -G docker vagrant
  CMD
  not_if "cat /etc/group | grep docker | grep vagrant"
end

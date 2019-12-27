include_recipe "./base.rb"

%w{
  dconf-cli
  dconf-editor
  ffmpeg
  libfreetype6-dev
  ubuntu-restricted-extras
}.each do |pkg|
  package pkg
end

include_recipe "../cookbooks/fonts.rb"
include_recipe "../cookbooks/adapta.rb"
include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"
include_recipe "../cookbooks/google-chrome.rb"
include_recipe "../cookbooks/gogh.rb"
include_recipe "../cookbooks/percona.rb"
include_recipe "../cookbooks/rkt.rb"
include_recipe "../cookbooks/snappy.rb"
include_recipe "../cookbooks/weechat.rb"

include_recipe "../cookbooks/protobuf.rb"
include_recipe "../cookbooks/grpc.rb"

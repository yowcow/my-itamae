include_recipe "./base.rb"

include_recipe "../cookbooks/fonts.rb"
include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"
include_recipe "../cookbooks/gogh.rb"
include_recipe "../cookbooks/rkt.rb"
include_recipe "../cookbooks/vagrant.rb"
include_recipe "../cookbooks/virtualbox.rb"
include_recipe "../cookbooks/weechat.rb"

%w{
  dconf-cli
  dconf-editor
  ffmpeg
  libav-tools
  libfreetype6-dev
  ubuntu-restricted-extras
}.each do |pkg|
  package pkg
end

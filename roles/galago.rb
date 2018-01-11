include_recipe "./base.rb"

include_recipe "../cookbooks/fonts.rb"
include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"
include_recipe "../cookbooks/gogh.rb"
include_recipe "../cookbooks/vagrant.rb"
include_recipe "../cookbooks/virtualbox.rb"

%w{
  ffmpeg
  libav-tools
  ubuntu-restricted-extras
}.each do |pkg|
  package pkg
end

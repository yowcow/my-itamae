include_recipe "./base.rb"

include_recipe "../cookbooks/fonts.rb"
include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"
include_recipe "../cookbooks/vagrant.rb"
include_recipe "../cookbooks/virtualbox.rb"

%w{
  ubuntu-restricted-extras
  libav-tools
  ffmpeg
}.each do |pkg|
  package pkg
end

include_recipe "./base.rb"

include_recipe "../cookbooks/fonts.rb"
include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"

%w{
  ubuntu-restricted-extras
  libav-tools
  ffmpeg
}.each do |pkg|
  package pkg
end

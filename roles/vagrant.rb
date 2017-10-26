include_recipe "./server.rb"

include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"

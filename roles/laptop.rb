include_recipe "./base.rb"

include_recipe "../cookbooks/common/desktop.rb"

include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"

#include_recipe "../cookbooks/base/centos.rb"
include_recipe "../cookbooks/base/ubuntu.rb"

include_recipe "../cookbooks/base/gitconfig.rb"
include_recipe "../cookbooks/base/profile.rb"

include_recipe "../cookbooks/mysql/default.rb"
include_recipe "../cookbooks/nginx/default.rb"

include_recipe "../cookbooks/anyenv/default.rb"
include_recipe "../cookbooks/anyenv/ndenv.rb"
include_recipe "../cookbooks/anyenv/plenv.rb"
#include_recipe "../cookbooks/rakudobrew/default.rb"

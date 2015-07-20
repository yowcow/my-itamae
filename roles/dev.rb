include_recipe "../cookbooks/base/default.rb"
include_recipe "../cookbooks/base/sysstat.rb"

include_recipe "../cookbooks/nginx/default.rb"
include_recipe "../cookbooks/nginx/yowcow.local.rb"

include_recipe "../cookbooks/anyenv/default.rb"
include_recipe "../cookbooks/anyenv/plenv.rb"
include_recipe "../cookbooks/anyenv/ndenv.rb"

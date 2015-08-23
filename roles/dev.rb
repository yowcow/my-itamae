include_recipe "../cookbooks/apt/default.rb"

include_recipe "../cookbooks/base/default.rb"
include_recipe "../cookbooks/base/sysstat.rb"

include_recipe "../cookbooks/mysql/default.rb"

include_recipe "../cookbooks/bdb/default.rb"

include_recipe "../cookbooks/nginx/default.rb"
include_recipe "../cookbooks/nginx/yowcow.local.rb"

include_recipe "../cookbooks/anyenv/default.rb"
include_recipe "../cookbooks/anyenv/plenv.rb"
include_recipe "../cookbooks/anyenv/ndenv.rb"

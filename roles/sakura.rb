include_recipe "./server.rb"

include_recipe "../cookbooks/letsencrypt.rb"
include_recipe "../cookbooks/mackerel.rb"

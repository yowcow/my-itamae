include_recipe "./base.rb"

include_recipe "../cookbooks/letsencrypt.rb"
include_recipe "../cookbooks/mysql-server.rb"
include_recipe "../cookbooks/nginx.rb"
include_recipe "../cookbooks/nginx/vh.rb"
include_recipe "../cookbooks/nginx/ssl.rb"
include_recipe "../cookbooks/znc.rb"

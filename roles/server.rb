include_recipe "./base.rb"

include_recipe "../cookbooks/certbot.rb"
include_recipe "../cookbooks/mysql-server.rb"
include_recipe "../cookbooks/nginx.rb"
include_recipe "../cookbooks/timesyncd.rb"
include_recipe "../cookbooks/timezone.rb"
include_recipe "../cookbooks/ufw.rb"
include_recipe "../cookbooks/znc.rb"

include_recipe "../cookbooks/common/essential.rb"
include_recipe "../cookbooks/common/development.rb"
include_recipe "../cookbooks/letsencrypt.rb"
include_recipe "../cookbooks/lua.rb"
include_recipe "../cookbooks/vim.rb"
include_recipe "../cookbooks/ctags.rb"
include_recipe "../cookbooks/tmux.rb"

include_recipe "../cookbooks/nodejs.rb"
include_recipe "../cookbooks/yarn.rb"
include_recipe "../cookbooks/perl.rb"
include_recipe "../cookbooks/golang.rb"
include_recipe "../cookbooks/erlang.rb"

include_recipe "../cookbooks/nginx.rb"
include_recipe "../cookbooks/nginx/vh.rb"
include_recipe "../cookbooks/mysql.rb"

include_recipe "../cookbooks/znc.rb"

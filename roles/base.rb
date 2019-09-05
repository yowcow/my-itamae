directory "/usr/local/etc/profile.d" do
  action :create
end

include_recipe "../cookbooks/apt.rb"
include_recipe "../cookbooks/common/essential.rb"
include_recipe "../cookbooks/common/development.rb"
include_recipe "../cookbooks/common/timezone.rb"
include_recipe "../cookbooks/common/user.rb"

include_recipe "../cookbooks/alp.rb"
include_recipe "../cookbooks/erlang.rb"
include_recipe "../cookbooks/git.rb"
include_recipe "../cookbooks/golang.rb"
include_recipe "../cookbooks/goreplay.rb"
include_recipe "../cookbooks/gotop.rb"
include_recipe "../cookbooks/mysql-common.rb"
include_recipe "../cookbooks/neovim.rb"
include_recipe "../cookbooks/nodejs.rb"
include_recipe "../cookbooks/perl.rb"
include_recipe "../cookbooks/python.rb"
include_recipe "../cookbooks/tmux.rb"
include_recipe "../cookbooks/travis.rb"
include_recipe "../cookbooks/vim.rb"
include_recipe "../cookbooks/yarn.rb"

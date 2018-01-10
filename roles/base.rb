$LSB_RELEASE = `cat /etc/lsb-release | grep CODENAME | cut -d "=" -f 2 | tr -d "\n"`

include_recipe "../cookbooks/apt.rb"
include_recipe "../cookbooks/common/essential.rb"
include_recipe "../cookbooks/common/development.rb"

include_recipe "../cookbooks/erlang.rb"
include_recipe "../cookbooks/git.rb"
include_recipe "../cookbooks/golang.rb"
include_recipe "../cookbooks/nodejs.rb"
include_recipe "../cookbooks/perl.rb"
include_recipe "../cookbooks/protobuf.rb"
include_recipe "../cookbooks/tmux.rb"
include_recipe "../cookbooks/travis.rb"
include_recipe "../cookbooks/vim.rb"
include_recipe "../cookbooks/yarn.rb"

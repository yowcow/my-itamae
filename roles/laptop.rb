include_recipe "./base.rb"

include_recipe "../cookbooks/desktop.rb"
include_recipe "../cookbooks/fonts.rb"
include_recipe "../cookbooks/keyboard.rb"
include_recipe "../cookbooks/system76.rb"

include_recipe "../cookbooks/chromium.rb"
include_recipe "../cookbooks/docker.rb"
include_recipe "../cookbooks/docker/compose.rb"
include_recipe "../cookbooks/gogh.rb"
include_recipe "../cookbooks/rkt.rb"
#include_recipe "../cookbooks/snappy.rb"
include_recipe "../cookbooks/timesyncd.rb"
include_recipe "../cookbooks/weechat.rb"

include_recipe "../cookbooks/protobuf.rb"
include_recipe "../cookbooks/grpc.rb"

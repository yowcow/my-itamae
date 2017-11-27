%w{
  blueman
  i3
  i3lock
  xautolock
}.each do |pkg|
  package pkg
end

include_recipe "../network-manager.rb"

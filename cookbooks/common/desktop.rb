%w{
  blueman
  i3
}.each do |pkg|
  package pkg
end

include_recipe "../gnome-i3.rb"

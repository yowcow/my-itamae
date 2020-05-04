%w{
  dconf-cli
  dconf-editor
  ffmpeg
  gnome-tweaks
  ibus-mozc
  libfreetype6-dev
  ubuntu-desktop
  ubuntu-restricted-extras
}.each do |pkg|
  package pkg
end

recipe "i3.rb"

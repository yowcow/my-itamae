%w{
  dconf-cli
  dconf-editor
  ffmpeg
  gnome-tweaks
  libfreetype6-dev
  ubuntu-desktop
  ubuntu-restricted-extras
}.each do |pkg|
  package pkg
end

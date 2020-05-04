%w{
  i3
}.each do |pkg|
  package pkg
end

revision = node["i3-gnome"][:revision]

src_dir       = "/usr/local/src/i3-gnome"
revision_file = "/usr/local/src/i3-gnome-revision"

current_revision = File.exists?(revision_file) ? File.open(revision_file).read.chomp : ""

if current_revision != revision then
  git src_dir do
    repository "https://github.com/i3-gnome/i3-gnome"
    revision revision
  end

  execute "Install i3-gnome" do
    command <<-CMD
      cd #{src_dir} && \
      make install
    CMD
  end

  file revision_file do
    content revision
    mode "0644"
  end
end

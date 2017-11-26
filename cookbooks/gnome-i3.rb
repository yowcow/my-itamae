template "/usr/share/xsessions/gnome-i3.desktop" do
  action :create
  source "gnome-i3/templates/xsessions/gnome-i3.desktop.erb"
  mode   "0644"
end

template "/usr/share/gnome-session/sessions/i3.session" do
  action :create
  source "gnome-i3/templates/gnome-session/sessions/i3.session.erb"
  mode   "0644"
end

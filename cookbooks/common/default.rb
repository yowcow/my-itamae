# For configuring /etc/default/*

remote_file "/etc/default/keyboard.bk" do
  source "/etc/default/keyboard"
  not_if "test -f /etc/default/keyboard.bk"
end

remote_file "/etc/default/keyboard" do
  source "files/etc/default/keyboard"
end

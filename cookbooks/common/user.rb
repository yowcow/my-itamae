group "znc" do
  gid 2001
end

user "znc" do
  uid 2001
  gid 2001
  system_user true
  shell "/bin/false"
  home "/var/lib/znc"
  create_home true
end

group "www-user" do
  gid 1100
end

user "www-user" do
  uid 1100
  gid 1100
  shell "/bin/false"
  home "/home/www-user"
  create_home true
end

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

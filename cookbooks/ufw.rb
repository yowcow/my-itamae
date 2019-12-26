execute "configure ufw" do
  command <<-CMD
    ufw default DENY
    ufw allow 22
    ufw allow 80
    ufw allow 443
    ufw allow 6699
    ufw allow 6697
    ufw reload
    ufw enable
  CMD
end

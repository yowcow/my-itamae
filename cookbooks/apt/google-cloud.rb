pub_key = "/usr/share/keyrings/cloud.google.gpg"

execute "Import Google Cloud public key" do
  command <<-CMD
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring #{pub_key} add -
  CMD
  not_if "test -f #{pub_key}"
end

file "/etc/apt/sources.list.d/google-cloud.list" do
  content <<-END
deb [signed-by=#{pub_key}] https://packages.cloud.google.com/apt cloud-sdk main
  END
  mode "0644"
end

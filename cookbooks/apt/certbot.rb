execute 'Add certbot apt repository' do
  command <<-CMD
    add-apt-repository -y ppa:certbot/certbot
  CMD
  not_if "apt-key list | grep certbot"
end

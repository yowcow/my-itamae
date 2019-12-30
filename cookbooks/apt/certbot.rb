execute 'Add certbot apt repository' do
  command <<-CMD
    add-apt-repository -y ppa:certbot/certbot
  CMD
end

execute 'Add system76 apt repository' do
  command <<-CMD
    apt-add-repository -ys ppa:system76-dev/stable
  CMD
  not_if "apt-key list | grep system76-dev"
end

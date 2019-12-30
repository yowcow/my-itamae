execute 'Add system76 apt repository' do
  command <<-CMD
    apt-add-repository -ys ppa:system76-dev/stable
  CMD
end

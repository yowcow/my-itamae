git "/usr/local/anyenv" do
  repository "https://github.com/riywo/anyenv.git"
end

execute "Default profile" do
  user "vagrant"
  command <<-CMD
    echo 'export ANYENV_ROOT=/usr/local/anyenv' >> /home/vagrant/.anyenvrc
    echo 'export PATH="${ANYENV_ROOT}/bin:$PATH"' >> /home/vagrant/.anyenvrc
    echo 'eval "$(anyenv init -)"' >> /home/vagrant/.anyenvrc
  CMD
  not_if "test -e /home/vagrant/.anyenvrc"
end

%w{
  plenv
  ndenv
}.each do |langenv|
  execute "Install #{langenv}" do
    command <<-CMD
      . /home/vagrant/.anyenvrc
      anyenv install #{langenv}
    CMD
    not_if "test -e /usr/local/anyenv/envs/#{langenv}"
  end
end

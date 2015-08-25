git "/home/vagrant/.anyenv" do
  repository "https://github.com/riywo/anyenv.git"
  action :sync
end

execute "Make files mine" do
  command <<-CMD
    chown -R vagrant:vagrant /home/vagrant/.anyenv
  CMD
end

execute "Default profile" do
  user "vagrant"
  command <<-CMD
    echo 'export ANYENV_ROOT=/home/vagrant/.anyenv' >> /home/vagrant/.anyenvrc
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
    user "vagrant"
    command <<-CMD
      . /home/vagrant/.anyenvrc
      anyenv install #{langenv}
    CMD
    not_if "test -e /home/vagrant/.anyenv/envs/#{langenv}"
  end
end

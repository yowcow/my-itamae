execute 'Add git-core apt repository' do
  command <<-CMD
    add-apt-repository -y ppa:git-core/ppa
  CMD
  not_if "apt-key list | grep git-core"
end

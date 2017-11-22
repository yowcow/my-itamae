execute 'Add git-core apt repository' do
  command <<-CMD
    add-apt-repository -y ppa:git-core/ppa && \
    apt update
  CMD
  not_if "apt-key list | grep git-core"
end

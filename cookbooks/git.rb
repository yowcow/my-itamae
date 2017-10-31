execute 'Add apt repository' do
  command <<-CMD
    add-apt-repository -y ppa:git-core/ppa && \
    apt update
  CMD
end

package 'git'

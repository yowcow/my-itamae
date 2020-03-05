%w{
  autoconf
  automake
  gcc
  libjansson-dev
  libseccomp-dev
  libyaml-dev
  libxml2-dev
  make
  pkg-config
  python3-docutils
}.each do |pkg|
  package pkg
end

revision = node["universal-ctags"][:revision]

src_dir       = "/usr/local/src/universal-ctags"
revision_file = "/usr/local/src/universal-ctags-revision"

prefix  = "/usr/local/universal-ctags"
profile = "/etc/profile.d/universal-ctags.sh"

current_revision = File.exists?(revision_file) ? File.open(revision_file).read.chomp : ""

if current_revision != revision then
  git src_dir do
    repository "https://github.com/universal-ctags/ctags"
  end

  execute "Install universal-ctags" do
    command <<-CMD
      cd #{src_dir} && \
      ./autogen.sh && \
      ./configure --prefix=#{prefix} && \
      make && \
      rm -rf #{prefix} && \
      make install
    CMD
  end

  file revision_file do
    content revision
    mode "0644"
  end
end

file profile do
  content <<-END
PATH=#{prefix}/bin:$PATH
  END
  mode "0644"
end

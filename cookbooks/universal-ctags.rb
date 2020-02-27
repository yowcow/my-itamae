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

src_dir      = "/usr/local/src/universal-ctags"
version_file = "/usr/local/src/universal-ctags-revision"

prefix  = "/usr/local/universal-ctags"
profile = "/etc/profile.d/universal-ctags.sh"

current_version = File.exists?(version_file) ? File.open(version_file).read.chomp : ""

if current_version != revision then
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

  file version_file do
    content revision
  end
end

file profile do
  content <<-END
PATH=#{prefix}/bin:$PATH
  END
  mode "0644"
end

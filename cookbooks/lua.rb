package "liblua5.3-dev"

link "/usr/local/include/lua" do
  to "/usr/include/lua5.3"
end

link "/usr/local/lib/liblua.so" do
  to "/usr/lib/x86_64-linux-gnu/liblua5.3.so"
end


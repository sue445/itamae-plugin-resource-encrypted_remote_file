encrypted_remote_file "/tmp/encrypted_file.txt" do
  owner    "root"
  group    "root"
  password "password"
end

encrypted_remote_file "/tmp/sue445.txt" do
  owner    "root"
  group    "root"
  source   "files/sue445.txt.encrypted"
  password "password"
end

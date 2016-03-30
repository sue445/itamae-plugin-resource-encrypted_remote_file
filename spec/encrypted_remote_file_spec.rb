describe file("/tmp/encrypted_file.txt") do
  it { should be_file }
  it { should exist }
  its(:content) { should eq "Secret Message" }
end

describe file("/tmp/sue445.txt") do
  it { should be_file }
  it { should exist }
  its(:content) { should eq "sue445\n" }
end

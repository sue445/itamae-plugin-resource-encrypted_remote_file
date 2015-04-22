describe Itamae::Plugin::Resource::EncryptedRemoteFile do
  let(:resource)      { Itamae::Plugin::Resource::EncryptedRemoteFile.new(recipe, resource_name) }
  let(:recipe)        { double("recipe") }
  let(:runner)        { double("runner") }
  let(:resource_name) { "/home/deployer/.ssh/id_rsa" }
  let(:password)      { "password" }

  before do
    allow(recipe).to receive(:dir)    { spec_dir }
    allow(recipe).to receive(:path)   { "#{spec_dir}/recipe.rb" }
    allow(recipe).to receive(:runner) { runner }
    allow(runner).to receive(:tmpdir) { "/tmp/itamae_tmp" }

    # NOTE: this is encrypted "Secret Message"
    resource.attributes.source   = "fixtures/encrypted_file.txt"
    resource.attributes.password = password
  end

  describe "#pre_action" do
    subject { resource.pre_action }

    it "should create decrypted file" do
      expect(resource).to receive(:send_file) do |src, dst|
        expect(dst).to be_an_instance_of(String)

        expect(src).to be_an_instance_of(String)
        expect(src).not_to eq "#{spec_dir}/fixtures/encrypted_file.txt"

        decrypt_data = File.read(src)
        expect(decrypt_data).to eq "Secret Message"
      end

      subject
    end

    after do
      tempfile = resource.instance_variable_get(:@decrypted_tempfile)
      tempfile.close! if tempfile
    end
  end
end

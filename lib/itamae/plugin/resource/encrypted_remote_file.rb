require "itamae"

module Itamae
  module Plugin
    module Resource
      require "tempfile"
      require "reversible_cryptography"

      class EncryptedRemoteFile < ::Itamae::Resource::RemoteFile
        define_attribute :password, type: String

        def pre_action
          encrypted_data = File.read(source_file).strip

          decrypted_data = ReversibleCryptography::Message.decrypt(encrypted_data, attributes.password)
          @decrypted_tempfile = Tempfile.open(File.basename(source_file)) do |f|
            f.write(decrypted_data)
            f
          end

          super
        end

        def content_file
          @decrypted_tempfile.path
        end

        def action_create(options)
          super

          @decrypted_tempfile.close! if @decrypted_tempfile
        end
      end
    end
  end
end

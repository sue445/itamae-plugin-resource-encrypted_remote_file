# Itamae::Plugin::Resource::EncryptedRemoteFile

encrypt secret data (ex. id_rsa), and forward decrypted file to remote.

This is like to [knife-solo_data_bag](https://github.com/thbishop/knife-solo_data_bag)

[![Gem Version](https://badge.fury.io/rb/itamae-plugin-resource-encrypted_remote_file.svg)](http://badge.fury.io/rb/itamae-plugin-resource-encrypted_remote_file)
[![Code Climate](https://codeclimate.com/github/sue445/itamae-plugin-resource-encrypted_remote_file/badges/gpa.svg)](https://codeclimate.com/github/sue445/itamae-plugin-resource-encrypted_remote_file)
[![Dependency Status](https://gemnasium.com/sue445/itamae-plugin-resource-encrypted_remote_file.svg)](https://gemnasium.com/sue445/itamae-plugin-resource-encrypted_remote_file)

[![wercker status](https://app.wercker.com/status/7b3074cbef6200439b30ef89eed393df/m/master "wercker status")](https://app.wercker.com/project/bykey/7b3074cbef6200439b30ef89eed393df)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-resource-encrypted_remote_file'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-resource-encrypted_remote_file

## Usage

### Encrypt data
install [reversible_cryptography](https://github.com/mitaku/reversible_cryptography)

```sh
gem install reversible_cryptography

reversible_cryptography encrypt --password=PASSWORD --src-file=/path/to/secret_file.txt --dst-file=/pass/to/encrypted_file.txt
```

### Recipe

```ruby
require "itamae-plugin-resource-encrypted_remote_file"

encrypted_remote_file "/home/deployer/.ssh/id_rsa" do
  owner    "root"
  group    "root"
  source   "remote_files/id_rsa.encrypted"
  password ENV["ID_RSA_PASSWORD"]
end
```

## ProTip
### Use with [dotenv](https://github.com/bkeepers/dotenv)

#### Gemfile
```ruby
gem "itamae-plugin-resource-encrypted_remote_file"
gem "dotenv"
```

#### .env (don't commit this!)
```sh
ID_RSA_PASSWORD=12345678
```

#### .gitignore
```
.env
```

#### your_recipe.rb
```ruby
require 'dotenv'
Dotenv.load

ENV["ID_RSA_PASSWORD"]
#=> "12345678"

encrypted_remote_file "/home/deployer/.ssh/id_rsa" do
  owner    "root"
  group    "root"
  source   "remote_files/id_rsa.encrypted"
  password ENV["ID_RSA_PASSWORD"]
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing
requirements [Vagrant](https://www.vagrantup.com/)

```sh
vagrant up centos70
bundle exec rake itamae:centos70
bundle exec rake spec:centos70
```

## Contributing

1. Fork it ( https://github.com/sue445/itamae-plugin-resource-encrypted_remote_file/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

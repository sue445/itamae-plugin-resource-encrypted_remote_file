# Itamae::Plugin::Resource::EncryptedRemoteFile

encrypt secret data (e.g. id_rsa), and forward decrypted file to remote.

This is like to [knife-solo_data_bag](https://github.com/thbishop/knife-solo_data_bag)

[![Gem Version](https://badge.fury.io/rb/itamae-plugin-resource-encrypted_remote_file.svg)](http://badge.fury.io/rb/itamae-plugin-resource-encrypted_remote_file)
[![Build Status](https://github.com/sue445/itamae-plugin-resource-encrypted_remote_file/workflows/test/badge.svg?branch=master)](https://github.com/sue445/itamae-plugin-resource-encrypted_remote_file/actions?query=workflow%3Atest)
[![Code Climate](https://codeclimate.com/github/sue445/itamae-plugin-resource-encrypted_remote_file/badges/gpa.svg)](https://codeclimate.com/github/sue445/itamae-plugin-resource-encrypted_remote_file)

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
encrypted_remote_file "/home/deployer/.ssh/id_rsa" do
  owner    "root"
  group    "root"
  source   "files/id_rsa.encrypted"
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
  source   "files/id_rsa.encrypted"
  password ENV["ID_RSA_PASSWORD"]
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing
requirements [Docker](https://www.docker.com/)

```sh
bundle exec itamae docker --node-yaml=recipes/node.yml recipes/install.rb --image=centos:7 --tag itamae-plugin:latest
DOCKER_IMAGE=itamae-plugin:latest bundle exec rspec
```

## Contributing

1. Fork it ( https://github.com/sue445/itamae-plugin-resource-encrypted_remote_file/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

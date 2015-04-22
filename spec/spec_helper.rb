if ENV["COVERAGE"]
  require 'coveralls'
  Coveralls.wear!
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "itamae/plugin/resource/encrypted_remote_file"

def spec_dir
  __dir__
end

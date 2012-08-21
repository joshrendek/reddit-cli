require 'rspec'
require 'vcr'
require 'pry'
VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :fakeweb# or :fakeweb
end

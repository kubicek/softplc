$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# $stdout = File.new('/dev/null', 'w')

require 'rubygems'
require 'minitest/autorun'
require 'shoulda'
require 'mocha'
require 'fakeweb'

require 'softplc'

# == Register FakeWeb URIs
FakeWeb.register_uri(:post, "http://127.0.0.2/splchmi.ashx", :body => File.read(Softplc.root.join('test/fixtures/values_response.xml')))
FakeWeb.allow_net_connect = false

class Minitest::Test

  def fixtures_path
    Pathname( File.expand_path( 'fixtures', File.dirname(__FILE__) ) )
  end

  def fixture_file(path)
    File.read File.expand_path( path, fixtures_path )
  end

end

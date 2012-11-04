require 'test_helper'

module Softplc
  class SoftplcTest < Test::Unit::TestCase

    context "Configuration" do

      should "should be allowed to be set" do
        assert_nothing_raised { 
          Softplc.configure do |config|
            config.host = '127.0.0.1'
          end
        }
      end

      should "have default host value" do
        Softplc.configuration = nil
        Softplc.configure {}
        assert_equal Softplc.configuration.host, '192.168.1.160'
      end

      should "set and retrieve value" do
        Softplc.configure do |config|
          config.host = '127.0.0.1'
        end
        assert_equal Softplc.configuration.host, '127.0.0.1'
      end

    end

  end
end

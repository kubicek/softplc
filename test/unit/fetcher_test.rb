require 'test_helper'

module Softplc
  class FetcherTest < Minitest::Test

        context "Fetcher" do

          setup do

            Softplc.configure do |config|
              config.host = '127.0.0.2'
            end

            uuids = [
              "46261352-25c4-4287-975a-1f01aceb6cca",
              "d864af63-fb44-459a-86d6-8f9024a0ed17",
              "236ce0d1-c8d7-45c0-a296-4ecbc2f455ec"
            ]
            @fetcher = Softplc::Fetcher.new(uuids)
          end

          should "parse correct values" do
            assert_equal "43.792884", @fetcher.sensors.detect{|sensor| sensor.uuid=="46261352-25c4-4287-975a-1f01aceb6cca"}.value
          end

        end

  end
end

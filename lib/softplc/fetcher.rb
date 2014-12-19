require "rest-client"
require "nokogiri"

module Softplc
  class Fetcher

    attr_accessor :sensors

    def initialize(uuids)
      @sensors = uuids.to_a.collect{ |uuid| Sensor.new(uuid: uuid)}
      prefetch
    end

    def self.create(sensor)
      instance.sensors << sensor unless instance.sensors.detect{|s| s.uuid==sensor.uuid}
      sensor
    end

    def prefetch
      while sensors.detect{|sensor| sensor.value.nil?}
        response = RestClient.post "http://#{Softplc.configuration.host}/splchmi.ashx", {}
        doc = Nokogiri.XML(response.body)
        doc.xpath("//xmlns:v[@esgid:vId]").each{|xml|
          uuid = xml.attributes["vId"].value.match(/svc:.*\/(.*)/)[1]
          value = xml.text
          if (sensor = sensors.detect{|sensor| sensor.uuid==uuid})
            sensor.value = value
          else
            sensors << Sensor.new(uuid: uuid, value: value)
          end
        }
      end
    end

    def sensors
      @sensors ||= []
    end
  end
end

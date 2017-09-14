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

    def to_request
      uuids_xml = sensors.collect{|sensor| "<v esgid:vId=\"svc://DefaultConnection/#{sensor.uuid}\" />"}.join
      '<?xml version="1.0" encoding="utf-8"?><splcComm xmlns="http://dev.rcware.net/xml/esgxmlrequest1.0" xmlns:esgid="http://dev.rcware.net/xml/esgid" xmlns:esg="http://dev.rcware.net/xml/esg" xmlns:esghmi="http://dev.rcware.net/xml/esghmi"><values>' +  uuids_xml + '</values></splcComm>'
    end

    def prefetch
      while sensors.detect{|sensor| sensor.value.nil?}
        response = RestClient.post "http://#{Softplc.configuration.user}:#{Softplc.configuration.pass}@#{Softplc.configuration.host}/splchmi.ashx", to_request, {:content_type => :xml}
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

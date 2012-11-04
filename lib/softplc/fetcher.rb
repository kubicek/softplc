require "rest-client"
require "nokogiri"

module Softplc
  class Fetcher

    attr_reader :uuids

    def initialize(uuids)
      @uuids = uuids.to_a
    end

    def to_request
      uuids_xml = uuids.to_a.collect{|uuid| "<v esgid:vId=\"svc://DefaultConnection/#{uuid}\" />"}.join
      
      '<?xml version="1.0" encoding="utf-8"?><splcComm xmlns="http://dev.rcware.net/xml/esgxmlrequest1.0" xmlns:esgid="http://dev.rcware.net/xml/esgid" xmlns:esg="http://dev.rcware.net/xml/esg" xmlns:esghmi="http://dev.rcware.net/xml/esghmi"><values>' +  uuids_xml + '</values>
</splcComm>'
    end

    def response
      @response ||= RestClient.post "http://#{Softplc.configuration.host}/splchmi.ashx", {}
    end
    
    def values
      doc = Nokogiri.XML(response.body)
      uuids.collect{|uuid|
        doc.xpath("//xmlns:v[@esgid:vId='svc://DefaultConnection/#{uuid}']").text
      }
    end

  end
end
module Softplc
  class Sensor
    attr_accessor :uuid, :value

    def initialize(params={})
      @uuid = params[:uuid]
      @value = params[:value]
    end
  end
end

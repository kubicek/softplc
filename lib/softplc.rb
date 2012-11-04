require "pathname"

Dir.glob("lib/softplc/**/*.rb").each { |file| require file }

module Softplc

  extend self

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :host

    def initialize
      @host = '192.168.1.160'
    end
  end

  def root
    Pathname( File.expand_path('../..', __FILE__) )
  end
end
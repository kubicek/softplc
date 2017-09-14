unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))
  $LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
end

require "pathname"
require "softplc/fetcher"
require "softplc/sensor"
require "softplc/version"

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
    attr_accessor :user, :pass, :host

    def initialize
      @host = '192.168.1.160'
    end
  end

  def root
    Pathname( File.expand_path('../..', __FILE__) )
  end
end

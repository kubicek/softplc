# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "softplc/version"

Gem::Specification.new do |s|
  s.name        = "softplc"
  s.version     = Softplc::VERSION
  s.authors     = ["Jiri Kubicek"]
  s.email       = ["jiri.kubicek@kraxnet.cz"]
  s.homepage    = ""
  s.summary     = %q{Ruby library for retrieving values from SoftPLC}
  s.description = %q{This gem uses webservice on Domat's MiniPLC to retrieve variables values'}

  s.rubyforge_project = "softplc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "mocha"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "turn"
  s.add_development_dependency "minitest"

  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "nokogiri"
end

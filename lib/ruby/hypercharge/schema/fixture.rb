# encoding: UTF-8

require 'json'

module Hypercharge
	module Schema::Fixture

	  def self.path
	  	"#{Dir.pwd}/test/fixtures/"
	  end

	  def self.xml(path)
	    IO.read(File.expand_path("../../../../../test/fixtures/#{path}.xml", __FILE__))
	  end

	  def self.json(path)
	    JSON.parse(IO.read(File.expand_path("../../../../../test/fixtures/#{path}.json", __FILE__)))
	  end

	end
end
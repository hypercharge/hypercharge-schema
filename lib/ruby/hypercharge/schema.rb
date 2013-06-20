# encoding: UTF-8

require "json-schema"
require "hypercharge/schema/version"
require "hypercharge/schema/fixture"


module Hypercharge
	module Schema

		# validates a hash with JSON-Schema
		def self.validate(type, data)
			JSON::Validator.fully_validate(schema_path_for(type), data)
		end

		# returns the path for a JSON-Schema
		# @param [Hypercharge::Payment::Type, Hypercharge::PaymentTransaction::Type] type  the type
		# @return [String] path
		def self.schema_path_for(type)
			File.expand_path("../../../../json/#{type}.json", __FILE__)
		end

		# yields with json schema files full path.
		# If you need the schema as hash, please feel free to IO.read() and JSON.parse().
		def self.each
			Dir[File.expand_path("../../../../json/*.json", __FILE__)].each do |path|
				yield path
			end
		end
	end
end

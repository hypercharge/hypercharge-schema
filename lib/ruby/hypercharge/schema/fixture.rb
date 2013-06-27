# encoding: UTF-8

require 'json'

module Hypercharge
	module Schema::Fixture

		# @param file String without ".xml" suffix e.g. "requests/sale" or "responses/WpfPayment_find"
		# @return String contents (xml string) of fixture file e.g. /foo/hypercharge-schema/test/fixtures/requests/sale.xml
		#                                         or   /foo/hypercharge-schema/test/fixtures/responses/WpfPayment_find.xml
		def self.xml(file)
			IO.read(path("#{file}.xml"))
		end

		# @param file String without ".json" suffix e.g. "requests/sale" or "responses/WpfPayment_find"
		# @return Hash parsed json fixture in e.g. /foo/hypercharge-schema/test/fixtures/requests/sale.json
		#                                      or  /foo/hypercharge-schema/test/fixtures/responses/WpfPayment_find.json
		def self.json(file)
			JSON.parse(IO.read(path("#{file}.json")))
		end

		# @param file String with (!) suffix e.g. "requests/sale.xml" or "responses/WpfPayment_find.json"
		# @return String absolute path e.g. "/foo/hypercharge-schema/test/fixtures/requests/sale.xml"
		#                               or  "/foo/hypercharge-schema/test/fixtures/responses/WpfPayment_find.json"
		def self.path(file)
			File.expand_path("../../../../../test/fixtures/#{file}", __FILE__)
		end

	end
end
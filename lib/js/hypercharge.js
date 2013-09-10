
var fs = require('fs')
var path = require('path')
var Validator = require('jsonschema').Validator;

var hypercharge = { VERSION: '1.24.6' };

hypercharge.Schema = {

	/**
	* sync
	* @param String type "sale", "authorize", "WpfPayment", "scheduler_create", ... see /json/*.json
	* @param Object data the data to validate
	*/
	validate: function(type, data) {
		var validator = new Validator();

		// cache types schema
	  if(!hypercharge.Schema._types) {
	  	var typesFile = hypercharge.Schema.schemaPathFor('types');
 		  hypercharge.Schema._types = JSON.parse(fs.readFileSync(typesFile));
	  }
		var schemaFile = hypercharge.Schema.schemaPathFor(type);
	  var schema = JSON.parse(fs.readFileSync(schemaFile));
		validator.addSchema(hypercharge.Schema._types, '/types.json');
		return validator.validate(data, schema);
	},

	schemaPathFor: function(type) {
		return path.resolve(__dirname, '../../json/', type+'.json');
	}

}

hypercharge.Schema.Fixture = {

	/**
	* sync
	* @param file String without ".xml" suffix e.g. "requests/sale" or "responses/WpfPayment_find"
	* @return String contents (xml string) of fixture file e.g. /foo/hypercharge-schema/test/fixtures/requests/sale.xml
	*                                         or   /foo/hypercharge-schema/test/fixtures/responses/WpfPayment_find.xml
	*/
	xml: function(file) {
		return fs.readFileSync(hypercharge.Schema.Fixture.path(file+'.xml'));
	},

	/**
	* sync
	* @param file String without ".json" suffix e.g. "requests/sale" or "responses/WpfPayment_find"
	* @return Hash parsed json fixture in e.g. /foo/hypercharge-schema/test/fixtures/requests/sale.json
	*                                      or  /foo/hypercharge-schema/test/fixtures/responses/WpfPayment_find.json
	*/
	json: function(file) {
		return JSON.parse(fs.readFileSync(hypercharge.Schema.Fixture.path(file+'.json')));
	},

	/**
	* resolve test fixture file path
	* @param String file e.g. "requests/sale.json" or "responses/sale.xml"
	* @return String the absolute file path
	*/
	path: function(file) {
		return path.resolve(__dirname, '../../test/fixtures/', file);
	}

}

module.exports = hypercharge;

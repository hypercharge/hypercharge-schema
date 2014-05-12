<?php
namespace Hypercharge;

const SCHEMA_VERSION = '1.24.7';

class JsonSchemaValidator {
	private $schemaUri;
	private $schema;

	/**
	* @param string $schemaName  e.g. "MobilePayment" for /json/MobilePayment.json  or "sale" for /json/sale.json
	*/
	function __construct($schemaName) {
		$this->schemaUri = 'file://'. self::schemaPathFor($schemaName);

		//var_dump('schemaUri', $this->schemaUri);

		$retriever = new \JsonSchema\Uri\UriRetriever;
		$this->schema = $retriever->retrieve($this->schemaUri);

		// If you use '$ref' or 'extends' or if you are unsure, resolve those references here
		// This modifies the $schema object
		$refResolver = new \JsonSchema\RefResolver($retriever);
		$refResolver->resolve($this->schema, $this->schemaUri);
	}

	/**
	* @param Object $object the instance to validate against the json schema
	* @return mixed array containing errors or false
	*/
	function check($object) {
		$validator = new \JsonSchema\Validator();
		$validator->check($object, $this->schema);
		$errors = $validator->getErrors();
		if(empty($errors)) return false;
		return $errors;
	}

	/**
	* @param string $schemaName  e.g. "MobilePayment" for /json/MobilePayment.json  or "sale" for /json/sale.json
	* @param Object $object the instance to validate against the json schema
	* @return mixed array containing errors or false
	*/
	static function validate($schemaName, $object) {
		$validator = new JsonSchemaValidator($schemaName);
		return $validator->check($object);
	}

	/**
	* doesn't check if schema file exists
	* @param string $type e.g. 'sale', 'authorize', 'capture', 'void', ...
	* @return string absolute path to schema file
	*/
	static function schemaPathFor($type) {
		return dirname(dirname(__DIR__)).'/json/'. $type .'.json';
	}
}
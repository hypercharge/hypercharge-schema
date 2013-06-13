<?php
namespace Hypercharge;

class JsonSchemaValidator {
	private $schemaUri;
	private $schema;

	/**
	* @param string $schemaName  e.g. "MobilePayment" for /json/MobilePayment.json  or "sale" for /json/sale.json
	*/
	function __construct($schemaName) {
		$this->schemaUri = 'file://'.dirname(dirname(__DIR__)).'/json/'.$schemaName.'.json';

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
}
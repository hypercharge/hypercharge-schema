<?php
require_once dirname(dirname(__DIR__)).'/vendor/autoload.php';
require_once dirname(dirname(__DIR__)).'/vendor/simpletest/simpletest/autorun.php';

class SchemaTestCase extends UnitTestCase {

	function __construct($schemaName=null) {
		parent::__construct();
		if(!isset($schemaName)) return;

		$this->validator = new \Hypercharge\JsonSchemaValidator($schemaName);
	}

	function fixture($file) {
		return file_get_contents(dirname(__DIR__).'/fixtures/requests/'. $file);
	}

	function assertValid($data = null) {
		if($data === null) $data = $this->data;
		$errors = $this->validator->check($data);
		$this->assertFalse($errors, "unexpected validation errors:\n".print_r($errors, true));
	}

	function assertNotValid($data = null) {
		if($data === null) $data = $this->data;
		$errors = $this->validator->check($data);
		$this->assertIsA($errors, 'array', "data should not be valid:\n".print_r($data, true));
	}
}

<?php
require_once dirname(dirname(__DIR__)).'/vendor/autoload.php';
require_once dirname(dirname(__DIR__)).'/vendor/vierbergenlars/simpletest/autorun.php';

class JsonSchemaValidatorTest extends UnitTestCase {

	function testSchemaPathForSale() {
		$file = \Hypercharge\JsonSchemaValidator::schemaPathFor('sale');
		$this->assertPattern('|/json/sale.json$|', $file);
		$this->assertTrue(file_exists($file), "file: $file");
	}

	function testSchemaPathForWpfPayment() {
		$file = \Hypercharge\JsonSchemaValidator::schemaPathFor('WpfPayment');
		$this->assertPattern('|/json/WpfPayment.json$|', $file);
		$this->assertTrue(file_exists($file), "file: $file");
	}

	function testSchemaPathForWrongType() {
		$file = \Hypercharge\JsonSchemaValidator::schemaPathFor('wrong_type');
		$this->assertPattern('|/json/wrong_type.json$|', $file);
		$this->assertTrue(! file_exists($file), "file does exist but should not: $file");
	}
}
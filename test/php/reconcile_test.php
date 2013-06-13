<?php
require_once 'test_helper.php';

class ReconcileTest extends SchemaTestCase {

	function __construct() {
		parent::__construct('reconcile');
		$this->jsonData = $this->fixture('reconcile.json');
	}

	function setUp() {
		$this->data = json_decode($this->jsonData);
		$this->reconcile = $this->data->reconcile;
	}

	function testFixtureShouldValidate() {
		$this->assertValid();
	}

	// TODO more tests
}
<?php
require_once 'test_helper.php';

class WpfPaymentTest extends SchemaTestCase {

	function __construct() {
		parent::__construct('WpfPayment');
		$this->jsonData = $this->fixture('WpfPayment.json');
	}

	function setUp() {
		$this->data = json_decode($this->jsonData);
		$this->payment = $this->data->payment;
	}

	function testFixtureShouldValidate() {
		$this->assertValid();
	}
}
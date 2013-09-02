<?php
require_once 'test_helper.php';

class SchedulerUpdateTest extends SchemaTestCase {

	function __construct() {
		parent::__construct('scheduler_update');
		$this->jsonData = $this->fixture('scheduler_update.json');
	}

	function setUp() {
		$this->data = json_decode($this->jsonData);
	}

	function testActiveBool() {
		$this->data->active = true;
		$this->assertValid();
	}

	function testNotActiveBool() {
		$this->data->active = false;
		$this->assertValid();
	}

	function testActiveInt() {
		$this->data->active = 1;
		$this->assertValid();
	}

	function testNotActiveInt() {
		$this->data->active = 0;
		$this->assertValid();
	}

	function testWithoutActive() {
		unset($this->data->active);
		$this->assertValid();
	}

	function testWithoutInterval() {
		unset($this->data->interval);
		$this->assertValid();
	}
}
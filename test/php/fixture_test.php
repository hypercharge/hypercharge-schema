<?php
require_once 'test_helper.php';

class FixtureTest extends UnitTestCase {

	function assertJson($str) {
		$this->assertPattern('/^\{/', $str);
	}

	function assertXml($str) {
		$this->assertPattern('/^<\?xml /', $str);
	}

	function testRequestSaleXml() {
		$xml = \Hypercharge\JsonSchemaFixture::request('sale.xml');
		$this->assertXml($xml);
	}

	function testRequestSaleJson() {
		$json = \Hypercharge\JsonSchemaFixture::request('sale.json');
		$this->assertJson($json);
		$data = json_decode($json);
		$this->assertIsA($data, 'stdClass');
		$this->assertEqual('sale', $data->payment_transaction->transaction_type);
	}

	function testResponseSchedulerErrorJson() {
		$json = \Hypercharge\JsonSchemaFixture::response('scheduler_error.json');
		$this->assertJson($json);
		$data = json_decode($json);
		$this->assertIdentical(340, $data->error->code);
	}

	function testNotificationJson() {
		$json = \Hypercharge\JsonSchemaFixture::notification('Scheduler_expiring.json');
		$this->assertJson($json);
		$data = json_decode($json);
		$this->assertIdentical('f433a0bf7c9681f39b82ace9d2af7e96', $data->recurring_schedule_unique_id);
	}
}
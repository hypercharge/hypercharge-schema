<?php
require_once 'test_helper.php';

class purchase_on_account_Test extends SchemaTestCase {

  function __construct() {
    parent::__construct('purchase_on_account');
    $this->jsonData = $this->fixture('purchase_on_account.json');
  }

  function setUp() {
    $this->data = json_decode($this->jsonData, true);
    $this->trx = $this->data['payment_transaction'];
  }

  function testFixtureShouldValidate() {
    $this->assertValid();
    $this->assertEqual('purchase_on_account', $this->trx['transaction_type']);
  }

  function testObjectRequired() {
    $this->data = null;
    $this->assertNotValid();
  }

  function testRootNodeRequired() {
    $this->data = new stdClass;
    $this->assertNotValid();
  }
}
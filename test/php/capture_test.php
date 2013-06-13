<?php
require_once 'test_helper.php';

class capture_Test extends SchemaTestCase {

	function __construct() {
		parent::__construct('capture');
		$this->jsonData = $this->fixture('capture.json');
	}

	function setUp() {
		$this->data = json_decode($this->jsonData);
		$this->trx = $this->data->payment_transaction;
	}

	function testFixtureShouldValidate() {
		$this->assertValid();
		$this->assertEqual('capture', $this->trx->transaction_type);
	}

	function testObjectRequired() {
		$this->data = null;
		$this->assertNotValid();
	}

	function testRootNodeRequired() {
		$this->data = new stdClass;
		$this->assertNotValid();
	}

	function testRootNodeContentsRequired() {
		$this->data->payment_transaction = new stdClass;
		$this->assertNotValid();
	}

	function testNoAdditionalFieldsAllowedInRoot() {
		$this->data->should_cause_validation_error = 'foo';
		$this->assertNotValid();
	}

	function testNoAdditionalFieldsAllowedInTrx() {
		$this->trx->should_cause_validation_error = 'foo';
		$this->assertNotValid();
	}

	function testTypeWrong() {
		$this->trx->transaction_type = 'sale';
		$this->assertNotValid();
	}

	function testTransactionId1Char() {
		$this->trx->transaction_id = 'a';
		$this->assertValid();
	}

	function testTransactionId255Char() {
		$this->trx->transaction_id = str_repeat('x', 255);
		$this->assertValid();
	}

	function testTransactionIdValidChars() {
		$this->trx->transaction_id = 'abcxyzABCDXYZ0123456789-_.';
		$this->assertValid();
	}

	function testTransactionIdSlashShouldBeInvalid() {
		$this->trx->transaction_id = '/';
		$this->assertNotValid();
	}

	function testTransactionId256CharShouldBeInvalid() {
		$this->trx->transaction_id = str_repeat('a', 256);
		$this->assertNotValid();
	}

	function testTransactionIdBackslashShouldBeInvalid() {
		$this->trx->transaction_id = '\\';
		$this->assertNotValid();
	}

	function testTransactionIdPlusShouldBeInvalid() {
		$this->trx->transaction_id = '+';
		$this->assertNotValid();
	}

	function testTransactionIdStarShouldBeInvalid() {
		$this->trx->transaction_id = '*';
		$this->assertNotValid();
	}

	function testTransactionIdEmpty() {
		$this->trx->transaction_id = '';
		$this->assertNotValid();
	}

	function testAmount1() {
		$this->trx->amount = 1;
		$this->assertValid();
	}
	function testAmount1000000000() {
		$this->trx->amount = 1000000000;
		$this->assertValid();
	}
	function testAmountMissing() {
		unset($this->trx->amount);
		$this->assertNotValid();
	}
	function testAmount1dot2() {
		$this->trx->amount = 1.2;
		$this->assertNotValid();
	}
	function testAmount0() {
		$this->trx->amount = 0;
		$this->assertNotValid();
	}
	function testAmountMinus1() {
		$this->trx->amount = -1;
		$this->assertNotValid();
	}
	function testAmountMinus1dot2() {
		$this->trx->amount = -1.2;
		$this->assertNotValid();
	}
	function testAmountFoo() {
		$this->trx->amount = 'foo';
		$this->assertNotValid();
	}

	function testCurrencyEUR() {
		$this->trx->currency = 'EUR';
		$this->assertValid();
	}
	function testCurrencyUSD() {
		$this->trx->currency = 'USD';
		$this->assertValid();
	}
	function testCurrencyMissing() {
		unset($this->trx->currency);
		$this->assertNotValid();
	}
	function testCurrencyEmptyString() {
		$this->trx->currency = '';
		$this->assertNotValid();
	}
	function testCurrencyEuroSign() {
		$this->trx->currency = '€';
		$this->assertNotValid();
	}
	function testCurrencyDollarSign() {
		$this->trx->currency = '$';
		$this->assertNotValid();
	}
	function testCurrencyXXX() {
		$this->trx->currency = 'XXX';
		$this->assertNotValid();
	}
	function testCurrency0() {
		$this->trx->currency = 0;
		$this->assertNotValid();
	}

	function testUsage1Char() {
		$this->trx->usage = 'x';
		$this->assertValid();
	}
	function testUsage255Char() {
		$this->trx->usage = str_repeat('_', 255);
		$this->assertValid();
	}
	function testUsageEmpty() {
		$this->trx->usage = '';
		$this->assertNotValid();
	}
	function testUsage256Char() {
		$this->trx->usage = str_repeat('_', 256);
		$this->assertNotValid();
	}
	function testUsageValidChars() {
		$this->trx->usage = "aAÄöéß1234 - _ / # '\" <b>";
		$this->assertValid();
	}
	function testUsageMissing() {
		unset($this->trx->usage);
		$this->assertValid();
	}

	function testRemoteIp_0_0_0_0() {
		$this->trx->remote_ip = "0.0.0.0";
		$this->assertNotValid();
	}
	function testRemoteIp_127_0_0_1() {
		$this->trx->remote_ip = "127.0.0.1";
		$this->assertNotValid();
	}
	function testRemoteIp255_255_255_255() {
		$this->trx->remote_ip = "255.255.255.255";
		$this->assertNotValid();
	}
	function testRemoteIp_0() {
		$this->trx->remote_ip = "0";
		$this->assertNotValid();
	}
	function testRemoteIpMissing() {
		unset($this->trx->remote_ip);
		$this->assertValid();
	}

	function testRefenrenceIdRequired() {
		unset($this->trx->reference_id);
		$this->assertNotValid();
	}
	function testRefenrenceIdEmpty() {
		$this->trx->reference_id = '';
		$this->assertNotValid();
	}
	function testRefenrenceIdBlank() {
		$this->trx->reference_id = str_repeat(' ', 32);
		$this->assertNotValid();
	}
	function testRefenrenceId_31_chars() {
		$this->trx->reference_id = str_repeat('a', 31);
		$this->assertNotValid();
	}
	function testRefenrenceId_32_chars() {
		$this->trx->reference_id = str_repeat('a', 32);
		$this->assertValid();
	}
	function testRefenrenceId_33_chars() {
		$this->trx->reference_id = str_repeat('a', 33);
		$this->assertNotValid();
	}
	function testRefenrenceId_255_chars() {
		$this->trx->reference_id = str_repeat('a', 256);
		$this->assertNotValid();
	}

	function testRiskParamsNotAllowed() {
		$this->trx->risk_params = json_decode($this->fixture('risk_params.json'));
		$this->assertNotValid();
	}
}
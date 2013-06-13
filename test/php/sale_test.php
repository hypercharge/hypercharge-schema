<?php
require_once 'test_helper.php';

class sale_Test extends SchemaTestCase {

	function __construct() {
		parent::__construct('sale');
		$this->jsonData = $this->fixture('sale.json');
	}

	function setUp() {
		$this->data = json_decode($this->jsonData);
		$this->trx = $this->data->payment_transaction;
	}

	function testFixtureShouldValidate() {
		$this->assertValid();
		$this->assertEqual('sale', $this->trx->transaction_type);
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
		$this->trx->transaction_type = 'authorize';
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
	function testUsage1Missing() {
		unset($this->trx->usage);
		$this->assertValid();
	}

	function testRemoteIp_0_0_0_0() {
		$this->trx->remote_ip = "0.0.0.0";
		$this->assertValid();
	}
	function testRemoteIp_127_0_0_1() {
		$this->trx->remote_ip = "127.0.0.1";
		$this->assertValid();
	}
	function testRemoteIp255_255_255_255() {
		$this->trx->remote_ip = "255.255.255.255";
		$this->assertValid();
	}
	function testRemoteIp_0_0_0() {
		$this->trx->remote_ip = "0.0.0";
		$this->assertNotValid();
	}
	function testRemoteIp_0_0() {
		$this->trx->remote_ip = "0.0";
		$this->assertNotValid();
	}
	function testRemoteIp_0() {
		$this->trx->remote_ip = "0";
		$this->assertNotValid();
	}
	function testRemoteIpMissing() {
		unset($this->trx->remote_ip);
		$this->assertNotValid();
	}

	function testCardHolderUmlaut() {
		$this->trx->card_holder = 'ä';
		$this->assertValid();
	}
	function testCardHolder255Chars() {
		$this->trx->card_holder = str_repeat('z', 255);
		$this->assertValid();
	}
	function testCardHolder256Chars() {
		$this->trx->card_holder = str_repeat('z', 256);
		$this->assertNotValid();
	}
	function testCardHolderEmpty() {
		$this->trx->card_holder = '';
		$this->assertNotValid();
	}
	function testCardHolderMissing() {
		unset($this->trx->card_holder);
		$this->assertNotValid();
	}

	function testCardNumber12Digits() {
		$this->trx->card_number = str_repeat('0', 12);
		$this->assertNotValid();
	}
	function testCardNumber13Digits() {
		$this->trx->card_number = str_repeat('0', 13);
		$this->assertValid();
	}
	function testCardNumber14Digits() {
		$this->trx->card_number = str_repeat('0', 14);
		$this->assertValid();
	}
	function testCardNumber15Digits() {
		$this->trx->card_number = str_repeat('0', 15);
		$this->assertValid();
	}
	function testCardNumber16Digits() {
		$this->trx->card_number = str_repeat('0', 16);
		$this->assertValid();
	}
	function testCardNumber17Digits() {
		$this->trx->card_number = str_repeat('0', 17);
		$this->assertNotValid();
	}
	function testCardNumberEmpty() {
		$this->trx->card_number = '';
		$this->assertNotValid();
	}
	function testCardNumberNull() {
		$this->trx->card_number = null;
		$this->assertNotValid();
	}
	function testCardNumberMissing() {
		unset($this->trx->card_number);
		$this->assertNotValid();
	}
	function testCardNumberInvalidChar() {
		$this->trx->card_number = '12345678901234 ';
		$this->assertNotValid();
	}

	function testCvv2Digits() {
		$this->trx->cvv = '12';
		$this->assertNotValid();
	}
	function testCcc3Digits() {
		$this->trx->cvv = '123';
		$this->assertValid();
	}
	function testCcc4Digits() {
		$this->trx->cvv = '1234';
		$this->assertValid();
	}
	function testCcc5Digits() {
		$this->trx->cvv = '12345';
		$this->assertNotValid();
	}
	function testCccEmpty() {
		$this->trx->cvv = '';
		$this->assertNotValid();
	}
	function testCccBlank() {
		$this->trx->cvv = '   ';
		$this->assertNotValid();
	}
	function testCccInvalidChars() {
		$this->trx->cvv = 'abcd';
		$this->assertNotValid();
	}
	function testCccMissing() {
		unset($this->trx->cvv);
		$this->assertValid();
	}

	function testExpirationMonth_00() {
		$this->trx->expiration_month = '00';
		$this->assertNotValid();
	}
	function testExpirationMonth_01() {
		$this->trx->expiration_month = '01';
		$this->assertValid();
	}
	function testExpirationMonth_02() {
		$this->trx->expiration_month = '02';
		$this->assertValid();
	}
	function testExpirationMonth_03() {
		$this->trx->expiration_month = '03';
		$this->assertValid();
	}
	function testExpirationMonth_04() {
		$this->trx->expiration_month = '04';
		$this->assertValid();
	}
	function testExpirationMonth_05() {
		$this->trx->expiration_month = '05';
		$this->assertValid();
	}
	function testExpirationMonth_06() {
		$this->trx->expiration_month = '06';
		$this->assertValid();
	}
	function testExpirationMonth_07() {
		$this->trx->expiration_month = '07';
		$this->assertValid();
	}
	function testExpirationMonth_08() {
		$this->trx->expiration_month = '08';
		$this->assertValid();
	}
	function testExpirationMonth_09() {
		$this->trx->expiration_month = '09';
		$this->assertValid();
	}
	function testExpirationMonth_1() {
		$this->trx->expiration_month = '1';
		$this->assertValid();
	}
	function testExpirationMonth_2() {
		$this->trx->expiration_month = '2';
		$this->assertValid();
	}
	function testExpirationMonth_3() {
		$this->trx->expiration_month = '3';
		$this->assertValid();
	}
	function testExpirationMonth_4() {
		$this->trx->expiration_month = '4';
		$this->assertValid();
	}
	function testExpirationMonth_5() {
		$this->trx->expiration_month = '5';
		$this->assertValid();
	}
	function testExpirationMonth_6() {
		$this->trx->expiration_month = '6';
		$this->assertValid();
	}
	function testExpirationMonth_7() {
		$this->trx->expiration_month = '7';
		$this->assertValid();
	}
	function testExpirationMonth_8() {
		$this->trx->expiration_month = '8';
		$this->assertValid();
	}
	function testExpirationMonth_9() {
		$this->trx->expiration_month = '9';
		$this->assertValid();
	}
	function testExpirationMonth_10() {
		$this->trx->expiration_month = '10';
		$this->assertValid();
	}
	function testExpirationMonth_11() {
		$this->trx->expiration_month = '11';
		$this->assertValid();
	}
	function testExpirationMonth_12() {
		$this->trx->expiration_month = '12';
		$this->assertValid();
	}
	function testExpirationMonth_13() {
		$this->trx->expiration_month = '13';
		$this->assertNotValid();
	}
	function testExpirationMonth_20() {
		$this->trx->expiration_month = '20';
		$this->assertNotValid();
	}
	function testExpirationMonth2LeadingZero() {
		$this->trx->expiration_month = '001';
		$this->assertNotValid();
	}

	function testExpirationYear_1999() {
		$this->trx->expiration_year = '1999';
		$this->assertNotValid();
	}
	function testExpirationYear_2000() {
		$this->trx->expiration_year = '2000';
		$this->assertValid();
	}
	function testExpirationYear_2001() {
		$this->trx->expiration_year = '2000';
		$this->assertValid();
	}
	function testExpirationYear_2013() {
		$this->trx->expiration_year = '2013';
		$this->assertValid();
	}
	function testExpirationYear_2013_int() {
		$this->trx->expiration_year = 2013;
		$this->assertNotValid();
	}
	function testExpirationYear_2015() {
		$this->trx->expiration_year = '2015';
		$this->assertValid();
	}
	function testExpirationYear_2016() {
		$this->trx->expiration_year = '2016';
		$this->assertValid();
	}
	function testExpirationYear_2020() {
		$this->trx->expiration_year = '2020';
		$this->assertValid();
	}
	function testExpirationYear_2021() {
		$this->trx->expiration_year = '2021';
		$this->assertValid();
	}
	function testExpirationYear_2022() {
		$this->trx->expiration_year = '2022';
		$this->assertValid();
	}
	function testExpirationYear_2030() {
		$this->trx->expiration_year = '2030';
		$this->assertValid();
	}
	function testExpirationYear_2100() {
		$this->trx->expiration_year = '2100';
		$this->assertNotValid();
	}
	function testExpirationYear_2999() {
		$this->trx->expiration_year = '2999';
		$this->assertNotValid();
	}
	function testExpirationYear_3000() {
		$this->trx->expiration_year = '3000';
		$this->assertNotValid();
	}
	function testExpirationYear_15() {
		$this->trx->expiration_year = '15';
		$this->assertNotValid();
	}
	function testExpirationYearMissing() {
		unset($this->trx->expiration_year);
		$this->assertNotValid();
	}
	function testExpirationYearBlank() {
		$this->trx->expiration_year = '';
		$this->assertNotValid();
	}

	function testCustomerEmail() {
		$this->trx->customer_email = 'this-is@an.email.com';
		$this->assertValid();
	}
	function testCustomerEmailInvalid() {
		$this->trx->customer_email = 'this is no email';
		$this->assertNotValid();
	}
	function testCustomerEmailMissing() {
		unset($this->trx->customer_email);
		$this->assertNotValid();
	}
	function testCustomerEmailBlank() {
		$this->trx->customer_email = '';
		$this->assertNotValid();
	}

	function testCustomerPhone() {
		$this->trx->customer_phone = '030/123 4536 123-78';
		$this->assertValid();
	}
	function testCustomerPhone1Char() {
		$this->trx->customer_phone = '1';
		$this->assertValid();
	}
	function testCustomerPhone255Char() {
		$this->trx->customer_phone = str_repeat('1', 255);
		$this->assertValid();
	}
	function testCustomerPhone256Char() {
		$this->trx->customer_phone = str_repeat('1', 256);
		$this->assertNotValid();
	}
	function testCustomerPhoneMissing() {
		unset($this->trx->customer_phone);
		$this->assertValid();
	}
	function testCustomerPhoneBlank() {
		$this->trx->customer_phone = '';
		$this->assertNotValid();
	}

	// billing_address tested en detail in mobile_payment_test.php
	function testBillingAddressMissing() {
		unset($this->trx->billing_address);
		$this->assertNotValid();
	}
	// random test
	function testBillingAddress_FirstNameMissing() {
		unset($this->trx->billing_address->first_name);
		$this->assertNotValid();
	}

	// risk_params tested en detail in mobile_payment_test.php
	function testRiskParams() {
		$this->trx->risk_params = json_decode($this->fixture('risk_params.json'));
		$this->assertValid();
	}
	// random test
	function testRiskParams_SessionIdEmpty() {
		$this->trx->risk_params = json_decode($this->fixture('risk_params.json'));
		$this->trx->risk_params->session_id = '';
		$this->assertNotValid();
	}

}
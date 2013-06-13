<?php
require_once 'test_helper.php';

class MobilePaymentTest extends SchemaTestCase {

	function __construct() {
		parent::__construct('MobilePayment');
		$this->jsonData = $this->fixture('MobilePayment.json');
	}

	function setUp() {
		$this->data = json_decode($this->jsonData);
		$this->payment = $this->data->payment;
	}

	function testFixtureShouldValidate() {
		$this->assertValid();
	}

	function testWrongRootNode() {
		$o = new stdClass;
		$o->wrong_root_node = $this->payment;
		$this->assertNotValid($o);
	}

	function testAdditionalRootNode() {
		$this->data->additional_node = 'foo';
		$this->assertNotValid();
	}
	function testAdditionalPaymentNode() {
		$this->data->payment->additional_node = 'foo';
		$this->assertNotValid();
	}

	function testAmount1() {
		$this->payment->amount = 1;
		$this->assertValid();
	}
	function testAmount1000000000() {
		$this->payment->amount = 1000000000;
		$this->assertValid();
	}
	function testAmountMissing() {
		unset($this->payment->amount);
		$this->assertNotValid();
	}
	function testAmount1dot2() {
		$this->payment->amount = 1.2;
		$this->assertNotValid();
	}
	function testAmount0() {
		$this->payment->amount = 0;
		$this->assertNotValid();
	}
	function testAmountMinus1() {
		$this->payment->amount = -1;
		$this->assertNotValid();
	}
	function testAmountMinus1dot2() {
		$this->payment->amount = -1.2;
		$this->assertNotValid();
	}
	function testAmountFoo() {
		$this->payment->amount = 'foo';
		$this->assertNotValid();
	}

	function testCurrencyEUR() {
		$this->payment->currency = 'EUR';
		$this->assertValid();
	}
	function testCurrencyUSD() {
		$this->payment->currency = 'USD';
		$this->assertValid();
	}
	function testCurrencyMissing() {
		unset($this->payment->currency);
		$this->assertNotValid();
	}
	function testCurrencyEmptyString() {
		$this->payment->currency = '';
		$this->assertNotValid();
	}
	function testCurrencyEuroSign() {
		$this->payment->currency = '€';
		$this->assertNotValid();
	}
	function testCurrencyDollarSign() {
		$this->payment->currency = '$';
		$this->assertNotValid();
	}
	function testCurrencyXXX() {
		$this->payment->currency = 'XXX';
		$this->assertNotValid();
	}
	function testCurrency0() {
		$this->payment->currency = 0;
		$this->assertNotValid();
	}

	function testNotificationUrlValidHttp() {
		$this->payment->notification_url = 'http://test-server.de/hypercharge/payment-notification.php';
		$this->assertValid();
	}
	function testNotificationUrlValidHttps() {
		$this->payment->notification_url = 'https://test-server.de/hypercharge/payment-notification.php';
		$this->assertValid();
	}
	function testNotificationUrlMissing() {
		unset($this->payment->notification_url);
		$this->assertNotValid();
	}
	function testNotificationUrlEmpty() {
		$this->payment->notification_url = '';
		$this->assertNotValid();
	}
	function testNotificationUrl77() {
		$this->payment->notification_url = 77;
		$this->assertNotValid();
	}
	function testNotificationUrlFileUri() {
		$this->payment->notification_url = 'file:///Home/homer/simpson.txt';
		$this->assertNotValid();
	}
	function testNotificationUrlShort() {
		$this->payment->notification_url = 'http://';
		$this->assertNotValid();
	}

	function testTransactionIdHex() {
		$this->payment->transaction_id = '1234efdaf32102423ad5f';
		$this->assertValid();
	}
	function testTransactionHexDashDot() {
		$this->payment->transaction_id = '1234efd-af3.210-2423ad5f';
		$this->assertValid();
	}

	function testBillingAddressNull() {
		$this->payment->billing_address = null;
		$this->assertNotValid();
	}
	function testBillingAddressMissing() {
		unset($this->payment->billing_address);
		$this->assertValid();
	}
	function testBillingAddress_FirstNameMissing() {
		unset($this->payment->billing_address->first_name);
		$this->assertNotValid();
	}
	function testBillingAddress_FirstNameBlank() {
		$this->payment->billing_address->first_name = '';
		$this->assertNotValid();
	}
	function testBillingAddress_LastNameMissing() {
		unset($this->payment->billing_address->last_name);
		$this->assertNotValid();
	}
	function testBillingAddress_LastNameBlank() {
		$this->payment->billing_address->last_name = '';
		$this->assertNotValid();
	}
	function testBillingAddress_Address1Missing() {
		unset($this->payment->billing_address->address1);
		$this->assertNotValid();
	}
	function testBillingAddress_Address1Blank() {
		$this->payment->billing_address->address1 = '';
		$this->assertNotValid();
	}
	function testBillingAddress_Address2Missing() {
		unset($this->payment->billing_address->address2);
		$this->assertValid();
	}
	function testBillingAddress_Address2Blank() {
		$this->payment->billing_address->address2 = '';
		$this->assertNotValid();
	}
	function testBillingAddress_CityMissing() {
		unset($this->payment->billing_address->city);
		$this->assertNotValid();
	}
	function testBillingAddress_CityBlank() {
		$this->payment->billing_address->city = '';
		$this->assertNotValid();
	}
	function testBillingAddress_ZipCodeMissing() {
		unset($this->payment->billing_address->zip_code);
		$this->assertNotValid();
	}
	function testBillingAddress_ZipCodeBlank() {
		$this->payment->billing_address->zip_code = '';
		$this->assertNotValid();
	}


	function testBillingAddress_StateAA() {
		$this->payment->billing_address->state = 'AA';
		$this->assertValid();
	}
	function testBillingAddress_StateLowercase() {
		$this->payment->billing_address->state = 'aa';
		$this->assertNotValid();
	}
	function testBillingAddress_StateWrong() {
		$this->payment->billing_address->state = 'XX';
		$this->assertNotValid();
	}
	function testBillingAddress_StateMissing() {
		unset($this->payment->billing_address->state);
		$this->assertValid();
	}
	function testBillingAddress_StateBlank() {
		$this->payment->billing_address->state = '';
		$this->assertNotValid();
	}

	function testBillingAddress_CountryUS() {
		$this->payment->billing_address->country = 'US';
		$this->assertValid();
	}
	function testBillingAddress_CountryLowercase() {
		$this->payment->billing_address->country = 'us';
		$this->assertNotValid();
	}
	function testBillingAddress_CountryWrong() {
		$this->payment->billing_address->country = 'XX';
		$this->assertNotValid();
	}
	function testBillingAddress_CountryMissing() {
		unset($this->payment->billing_address->country);
		$this->assertNotValid();
	}
	function testBillingAddress_CountryBlank() {
		$this->payment->billing_address->country = '';
		$this->assertNotValid();
	}
}

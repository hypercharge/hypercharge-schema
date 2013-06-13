'use strict';

/*jsl predef:define*/
/*jsl predef:it*/

var util = require('util')
var fs = require('fs')
var assert = require('chai').assert
var Validator = require('jsonschema').Validator


describe('MobilePayment', function () {
	var json, validator, schema, paymentSchema, paymentRequest, payment;

	beforeEach(function () {
		if(!json) {
			json = {
				schema  :fs.readFileSync('json/MobilePayment.json')
				,paymentSchema :fs.readFileSync('json/Payment.json')
				,types  :fs.readFileSync('json/types.json')
				,request:fs.readFileSync('test/fixtures/MobilePayment.json')
			}
		}
		validator = new Validator()
	  schema            = JSON.parse(json.schema)
	  paymentRequest    = JSON.parse(json.request)
	  validator.addSchema(JSON.parse(json.paymentSchema), '/Payment.json')
		validator.addSchema(JSON.parse(json.types), '/types.json')
		payment = paymentRequest.payment
	})

	function assertValid(payment) {
		validate(payment, true)
	}
	function assertNotValid(payment) {
		validate(payment, false)
	}
	function validate(payment, bool) {
		var result = validator.validate(payment, schema)
		assert.strictEqual(result.valid, bool, util.inspect(result.errors, { showHidden: false, depth: 1 }))
	}

	describe('fixture', function () {
		it('should validate', function () {
			assertValid(paymentRequest)
		})
		it('with wrong root node is not valid', function(){
			assertNotValid({wrong_root:payment})
		})
		it('should not allow additional root nodes', function(){
			paymentRequest.additional_node = 'foo';
			assertNotValid(paymentRequest)
		})

		// TODO the ruby json-schema validator doesnt work with additionalProperties:false in MobilePayment.json
		// atm. the restriction is off.
		it('should not allow additional payment nodes', function(){
			paymentRequest.payment.additional_node = 'foo';
			assertNotValid(paymentRequest)
		})
	})

	describe('amount valid', function() {
		it('1', function () {
			payment.amount = 1;
			assertValid(paymentRequest)
		})
		it('1000000000', function () {
			payment.amount = 1000000000;
			assertValid(paymentRequest)
		})
	})

	describe('amount not valid', function() {
		it('missing', function () {
			delete(payment.amount)
			assertNotValid(paymentRequest)
		})
		it('1.2', function () {
			payment.amount = 1.2;
			assertNotValid(paymentRequest)
		})
		it('0', function () {
			payment.amount = 0;
			assertNotValid(paymentRequest)
		})
		it('-1', function () {
			payment.amount = -1;
			assertNotValid(paymentRequest)
		})
		it('-1.2', function () {
			payment.amount = -1.2;
			assertNotValid(paymentRequest)
		})
		it('foo', function () {
			payment.amount = 'foo';
			assertNotValid(paymentRequest)
		})
	})

	describe('currency valid', function() {
		it('EUR', function () {
			payment.currency = 'EUR';
			assertValid(paymentRequest)
		})
		it('USD', function () {
			payment.currency = 'USD';
			assertValid(paymentRequest)
		})
	})

	describe('currency not valid', function() {
		it('missing', function () {
			delete(payment.currency)
			assertNotValid(paymentRequest)
		})
		it('""', function () {
			payment.currency = ''
			assertNotValid(paymentRequest)
		})
		it('€', function () {
			payment.currency = '€';
			assertNotValid(paymentRequest)
		})
		it('$', function () {
			payment.currency = '$';
			assertNotValid(paymentRequest)
		})
		it('XXX', function () {
			payment.currency = 'XXX';
			assertNotValid(paymentRequest)
		})
		it('0', function () {
			payment.amount = 0;
			assertNotValid(paymentRequest)
		})
	})

	describe('notification_url valid', function() {
		it('http', function () {
			payment.notification_url = 'http://test-server.de/hypercharge/payment-notification.php';
			assertValid(paymentRequest)
		})
		it('https', function () {
			payment.notification_url = 'https://test-server.de/hypercharge/payment-notification.php';
			assertValid(paymentRequest)
		})
	})

	describe('notification_url not valid', function() {
		it('missing', function () {
			delete(payment.notification_url)
			assertNotValid(paymentRequest)
		})
		it('""', function () {
			payment.notification_url = '';
			assertNotValid(paymentRequest)
		})
		it('77', function () {
			payment.notification_url = 77;
			assertNotValid(paymentRequest)
		})
		it('"file:///...."', function () {
			payment.notification_url = "file:///Home/homer/simpson.txt";
			assertNotValid(paymentRequest)
		})
		it('http but too short', function () {
			payment.notification_url = 'http://';
			assertNotValid(paymentRequest)
		})
	})

	describe('customer_email valid', function() {
		it('jan@hypercharge.net', function () {
			payment.customer_email = 'jan@hypercharge.net';
			assertValid(paymentRequest)
		})
		it('missing', function () {
			delete(payment.customer_email)
			assertValid(paymentRequest)
		})
	})

	describe('customer_email not valid', function() {
		it('""', function () {
			payment.customer_email = ''
			assertNotValid(paymentRequest)
		})
		it('null', function () {
			payment.customer_email = null
			assertNotValid(paymentRequest)
		})
	})


	describe('billing_address', function() {
		it('missing is valid', function () {
			assert.typeOf(payment.billing_address, 'object', 'billing_address')
			delete(payment.billing_address)
			assertValid(paymentRequest)
		})

		it('missing first_name is invalid', function () {
			delete(payment.billing_address.first_name)
			assertNotValid(paymentRequest)
		})
		it('missing last_name is invalid', function () {
			delete(payment.billing_address.last_name)
			assertNotValid(paymentRequest)
		})
		it('missing address1 is invalid', function () {
			delete(payment.billing_address.address1)
			assertNotValid(paymentRequest)
		})
		it('missing address2 is valid', function () {
			delete(payment.billing_address.address2)
			assertValid(paymentRequest)
		})
		it('missing city is invalid', function () {
			delete(payment.billing_address.city)
			assertNotValid(paymentRequest)
		})
		it('missing zip_code is invalid', function () {
			delete(payment.billing_address.zip_code)
			assertNotValid(paymentRequest)
		})
		it('missing country is invalid', function () {
			delete(payment.billing_address.country)
			assertNotValid(paymentRequest)
		})
		it('present state invalid', function () {
			payment.billing_address.state = 'CA'
			assertValid(paymentRequest)
		})
		it('wrong state invalid', function () {
			payment.billing_address.state = 'ZZ'
			assertNotValid(paymentRequest)
		})
	})


	describe('expires_in valid', function() {
		it('min', function () {
			payment.expires_in = 300;
			assertValid(paymentRequest)
		})
		it('between', function () {
			payment.expires_in = 5000;
			assertValid(paymentRequest)
		})
		it('float but quasi int', function () {
			payment.expires_in = 5000.0;
			assertValid(paymentRequest)
		})
		it('max', function () {
			payment.expires_in = 86400;
			assertValid(paymentRequest)
		})
		it('missing', function () {
			delete(payment.expires_in)
			assertValid(paymentRequest)
		})
	})

	describe('expires_in not valid', function() {
		it('""', function () {
			payment.expires_in = ''
			assertNotValid(paymentRequest)
		})
		it('null', function () {
			payment.expires_in = null
			assertNotValid(paymentRequest)
		})
		it('min -1', function () {
			payment.expires_in = 300 -1;
			assertNotValid(paymentRequest)
		})
		it('max +1', function () {
			payment.expires_in = 86400 +1;
			assertNotValid(paymentRequest)
		})
		it('float', function () {
			payment.expires_in = 5000.1;
			assertNotValid(paymentRequest)
		})
	})
})

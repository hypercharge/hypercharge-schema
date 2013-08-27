# hypercharge-schema

json-schema for hypercharge payment request data.

[![Build Status](https://travis-ci.org/hypercharge/hypercharge-schema.png?branch=master)](https://travis-ci.org/hypercharge/hypercharge-schema)
[![Gem Version](https://badge.fury.io/rb/hypercharge-schema.png)](http://badge.fury.io/rb/hypercharge-schema)

## Fixtures

There is a rather complete set of hypercharge API xml requests, respsonses and notifications provided as fixtures in ```/test/fixtures/```

A fixture loader is provided for php, ruby and javascript.

php:
```php
// requests to hypercharge
$xmlString = Hypercharge\JsonSchemaFixture::request('sale.xml');
// or as json string
$jsonString = Hypercharge\JsonSchemaFixture::request('sale.json');
// response from hypercharge
$xmlString = Hypercharge\JsonSchemaFixture::response('sale.xml');
```

ruby:
```ruby
# request to hypercharge
xmlString = Hypercharge::Schema::Fixture.xml 'request/sale'
# or as parsed json
jsonData = Hypercharge::Schema::Fixture.json 'request/sale'
# response from hypercharge
xmlString = Hypercharge::Schema::Fixture.xml 'response/sale'
```

javascript (sync, no async atm.):
```javascript
var Schema = require('hypercharge-schema').Schema;

// request to hypercharge
var xmlString = Schema.Fixture.xml('request/sale');
// or as parsed json
var jsonData = Schema.Fixture.json('request/sale');
// response from hypercharge
var xmlString = Schema.Fixture.xml('response/sale');
```

## Tests

### Ruby

ruby >= 1.9.3

Install dependencies

	bundle

Run tests

	rake

### PHP

php >= 5.3

Install Composer and dependencies

	curl -o composer.phar http://getcomposer.org/composer.phar
	php composer.phar install
	php composer.phar update --dev

run test

	php test/php/all.php

### JavaScript

Install [node.js](http://nodejs.org/)

Install dependencies

	npm install

run test

	npm test

Btw: [nvm](https://github.com/creationix/nvm) is a handy tool for installing and handling multiple node.js versions on one mashine.

## Warranty

This software is provided "as is" and without any express or implied warranties, including, without limitation, the implied warranties of merchantibility and fitness for a particular purpose.
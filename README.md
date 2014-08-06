# hypercharge-schema

json-schema for hypercharge payment request data.

Matches hypercharge API pdf documention version 2.23 2014/08/05

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

// notification from hypercharge
$postData = json_decode(Hypercharge\JsonSchemaFixture::notification('transaction_notification.json'), true);
```

ruby:
```ruby
# request to hypercharge
xmlString = Hypercharge::Schema::Fixture.xml 'requests/sale'

# or as parsed json
jsonData = Hypercharge::Schema::Fixture.json 'requests/sale'

# response from hypercharge
xmlString = Hypercharge::Schema::Fixture.xml 'responses/sale'

# notification from hypercharge
jsonData = Hypercharge::Schema::Fixture.json 'notifications/transaction_notification'
```

javascript (sync, no async atm.):
```javascript
var Schema = require('hypercharge-schema').Schema;

// request to hypercharge
var xmlString = Schema.Fixture.xml('requests/sale');

// or as parsed json
var jsonData = Schema.Fixture.json('requests/sale');

// response from hypercharge
var xmlString = Schema.Fixture.xml('responses/sale');

// notification from hypercharge
var postData = Schema.Fixture.json('notifications/transaction_notification');
```

## Tests

Assuming you have all dependencies installed (see below) you can run all tests (ruby, php, javascript) at once.
```sh
./test/all.sh
```
Or one by one:

### Ruby

ruby >= 1.9.3

Install dependencies

	bundle

Run tests

	rake

### PHP

php >= 5.3

Install Composer and dependencies
```sh
curl -o composer.phar http://getcomposer.org/composer.phar
php composer.phar install
php composer.phar update --dev
```
run test

```sh
php test/php/all.php
```

### JavaScript

Install [node.js](http://nodejs.org/)

Install dependencies
```sh
npm install
```

run test
```sh
npm test
```

Btw: [nvm](https://github.com/creationix/nvm) is a handy tool for installing and handling multiple node.js versions on one mashine.

## Warranty

This software is provided "as is" and without any express or implied warranties, including, without limitation, the implied warranties of merchantibility and fitness for a particular purpose.
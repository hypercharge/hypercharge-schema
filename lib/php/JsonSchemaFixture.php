<?php
namespace Hypercharge;

class JsonSchemaFixture {
	static function request($file) {
		return file_get_contents(dirname(dirname(__DIR__)).'/test/fixtures/requests/'. $file);
	}
	static function response($file) {
		return file_get_contents(dirname(dirname(__DIR__)).'/test/fixtures/responses/'. $file);
	}
	// TODO notification
}
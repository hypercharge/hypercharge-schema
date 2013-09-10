<?php
namespace Hypercharge;

class JsonSchemaFixture {

	/**
	* @param string $file filename of request fixture. e.g. 'sale.xml'
	* @return string contents of request fixture file
	*/
	static function request($file) {
		return file_get_contents(self::fixturesDir().'requests/'. $file);
	}

	/**
	* @param string $file filename of response fixture. e.g. 'sale.xml'
	* @return string contents of response fixture file
	*/
	static function response($file) {
		return file_get_contents(self::fixturesDir().'responses/'. $file);
	}

	/**
	* @param string $file filename of notification fixture. e.g. 'Scheduler_expiring.json'
	* @return string contents of notification fixture file
	*/
	static function notification($file) {
		return file_get_contents(self::fixturesDir().'notifications/'. $file);
	}

	/**
	* @return string absolute path to test/fixtures/
	*/
	static function fixturesDir() {
		return dirname(dirname(__DIR__)).'/test/fixtures/';
	}
}
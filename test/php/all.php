<?php
require_once 'test_helper.php';

class AllTests extends TestSuite {
	function AllTests() {
		$this->TestSuite('All tests');
		$this->collect(__DIR__, new SimplePatternCollector('/_test\.php$/'));
	}
}

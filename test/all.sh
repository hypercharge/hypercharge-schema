#!/bin/bash

echo
echo 'running tests for ruby, php, javascript'
echo
echo '---- ruby ----'
bundle exec rake
RUBY_OK=$?

echo
echo '---- php ----'
php test/php/all.php
PHP_OK=$?

echo
echo '---- javascript ----'
echo 'try to use latests nodejs 0.10.x version'
nvm use 0.10
npm test
JAVASCRIPT_OK=$?

# # for testing the summary
# RUBY_OK=0
# PHP_OK=0
# JAVASCRIPT_OK=0

let total=$RUBY_OK+$PHP_OK+$JAVASCRIPT_OK

echo '---------------------------------'
[ $total == 0 ] && echo 'ok' || echo 'SOME TESTS FAILED!'

echo '---------------------------------'

echo -n 'ruby         '
[ $RUBY_OK == 0 ] && echo 'ok' || echo 'FAILED'
echo -n 'php          '
[ $PHP_OK == 0 ] && echo 'ok' || echo 'FAILED'
echo -n 'javascript   '
[ $JAVASCRIPT_OK == 0 ] && echo 'ok' || echo 'FAILED'
echo '---------------------------------'

exit $total

all: compile_coffeescript

default: compile_coffeescript

compile_tests:
	node_modules/coffee-script/bin/coffee -c -o test test/*.coffee coffee/*.coffee

test: compile_tests
	node_modules/mocha-phantomjs/bin/mocha-phantomjs test/runner.html

compile_coffeescript:
	node_modules/coffee-script/bin/coffee -c -o public/scripts/app coffee/*.coffee

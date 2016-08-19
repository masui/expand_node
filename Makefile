xxx:
	coffee -b -c -o lib src
	browserify lib/main.js -o lib/xxx.js

test:
	coffee src/test2.coffee
build:
	coffee -b -c -o lib src
clean:


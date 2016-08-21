#
# Coffeeで書いたsrc/*.coffeeをJSに変換し、ブラウザ対応させる
#
xxx:
	coffee -b -c -o lib src
	browserify lib/main.js -o main.js

test:
	coffee sample/sample1.coffee
	coffee sample/sample2.coffee
	coffee sample/sample3.coffee

build:
	coffee -b -c -o lib src

publish:
	npm publish

clean:


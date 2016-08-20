#
# Coffeeで書いたsrc/*.coffeeをJSに変換し、ブラウザ対応させる
#
xxx:
	coffee -b -c -o lib src
	browserify lib/main.js -o main.js

test:
	coffee src/test2.coffee
build:
	coffee -b -c -o lib src
clean:


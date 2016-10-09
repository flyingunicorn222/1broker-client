.PHONY: docs

install:
	npm install

docs:
	rm -rf ./docs
	./node_modules/.bin/docco src/{**/*,*} -l linear

clean:
	rm -rf ./lib
	rm -rf ./docs

build:
	rm -rf ./lib
	./node_modules/.bin/coffee --bare -o lib/ -c src/

publish:
	npm publish

test:
	./node_modules/.bin/nodemon --watch src -e coffee --exec "coffee ./tests/account_overview.coffee"
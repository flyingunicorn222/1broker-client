.PHONY: docs test

NODEMON=./node_modules/.bin/nodemon
MOCHA=./node_modules/.bin/mocha

install:
	npm install

docs:
	#rm -rf ./docs
	./node_modules/.bin/docco src/{**/*,*} -l linear

clean:
	rm -rf ./lib
	#rm -rf ./docs

build:
	rm -rf ./lib
	./node_modules/.bin/coffee --bare -o lib/ -c src/
	./node_modules/.bin/coffee scripts/fetch_details.coffee
	cp src/info/details.json lib/info/details.json

publish:
	npm publish

test:
	$(MOCHA) test/*.coffee

auto.test:
	$(NODEMON) --watch test --watch src -e coffee --exec "$(MOCHA) test/*.coffee"

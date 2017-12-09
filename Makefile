EOSDIR = ~/eos
EOSCPP = $(EOSDIR)/build/tools/eoscpp
EOSC = $(EOSDIR)/build/programs/eosc/eosc
EOSD = $(EOSDIR)/build/programs/eosd/eosd
GENESIS_JSON = $(EOSDIR)/genesis.json
DATA_DIR = $(PWD)/data-dir
CONFIG_INI = $(PWD)/config.ini

start-static: build
	`npm bin`/concurrently \
		--raw \
		--kill-others \
		"make watch-html" \
		"make watch-css" \
		"make watch-js" \
		"make start-static-server"

eosd:
	mkdir -p $(DATA_DIR)
	ln -sf $(CONFIG_INI) $(DATA_DIR)
	$(EOSD) \
		--data-dir $(DATA_DIR) \
		--genesis-json $(GENESIS_JSON)

eosd-docker:
	mkdir -p $(DATA_DIR)
	rm -f $(DATA_DIR)/config.ini
	cp -f $(CONFIG_INI) $(DATA_DIR)
	cp -f $(GENESIS_JSON) $(DATA_DIR)
	docker run --name eosd \
		-v $(DATA_DIR):/opt/eos/bin/data-dir \
		-p 8888:8888 \
		-p 9876:9876 \
		-t eosio/eos \
		start_eosd.sh arg1 arg2

start-static-server:
	`npm bin`/browser-sync start \
		--server "docs" \
		--no-ui \
		--no-open

build: build-contracts build-js build-html build-css

dist-dir:
	mkdir -p docs

CONTRACT_NAME = tic.tac.toe
WALLET_PASS = PW5KaCvVB318EfJhLWJCaxeX4X5787tJtgsAVvcB2fiQ2AmhYNs2J
INITA_PRIVATE = 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
INITA_PUBLIC = EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV

setup-env:
	$(EOSC) wallet create
	$(EOSC) wallet open
	$(EOSC) wallet import $(INITA_PRIVATE)

create-contract-account:
	$(EOSC) create account inita $(CONTRACT_NAME) $(INITA_PUBLIC) $(INITA_PUBLIC)

test-contract:
	$(EOSC) push message $(CONTRACT_NAME) create "{ \"challenger\": \"initb\", \"host\": \"inita\" }" --scope inita,initb --permission "inita@active"
	# $(EOSC) get table inita $(CONTRACT_NAME) games
	# $(EOSC) get table initb $(CONTRACT_NAME) games
	# $(EOSC) get table inita $(CONTRACT_NAME) games
	# $(EOSC) get table initb $(CONTRACT_NAME) games
	$(EOSC) get table inita $(CONTRACT_NAME) games
	$(EOSC) get table initb $(CONTRACT_NAME) invites
	# $(EOSC) push message $(CONTRACT_NAME) close "{ \"challenger\": \"initb\", \"host\": \"inita\" }" --scope inita,initb --permission "inita@active"
	

try-contract: deploy-contracts test-contract

build-contracts: dist-dir
	rm -f src/contracts/eoslib
	ln -sf $(EOSDIR)/contracts/eoslib src/contracts/eoslib
	$(EOSCPP) -o src/contracts/tic_tac_toe.wast src/contracts/tic_tac_toe.cpp

deploy-contracts: build-contracts
	$(EOSC) set contract tic.tac.toe src/contracts/tic_tac_toe.wast src/contracts/tic_tac_toe.abi

watch-contracts:
	`npm bin`/nodemon \
		--on-change-only \
		--ext abi,cpp,hpp \
		--watch src \
		--exec "make build-contracts || exit 0"

build-js: dist-dir
	`npm bin`/elm-make \
		src/elm/Main.elm \
		--output src/elm/index.js
	`npm bin`/browserify \
		src/index.ts \
		--plugin tsify \
		--transform brfs \
		--outfile docs/index.js

watch-js:
	`npm bin`/nodemon \
		--on-change-only \
		--ext ts,wasm \
		--watch src \
		--exec "make build-js || exit 0"

build-css: dist-dir
	cp src/index.css docs

watch-css:
	`npm bin`/nodemon \
		--on-change-only \
		--ext css \
		--watch src \
		--exec "make build-css || exit 0"

build-html: dist-dir
	cp src/index.html docs

watch-html:
	`npm bin`/nodemon \
		--on-change-only \
		--ext css \
		--watch src \
		--exec "make build-css || exit 0"

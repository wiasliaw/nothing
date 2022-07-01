all:; forge build

install:; forge install

test:; forge test

example:; FOUNDRY_PROFILE=example forge test -vvvv

clean:; rm -rf cache dist

.PHONY: test example

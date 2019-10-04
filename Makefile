.ONESHELL:
.SHELLFLAGS: -e -u

# Source the .env.sh
source = source .env.sh || true

.DEFAULT_GOAL := build

setup-env: .env.sh
.env.sh: .env.example.sh
	@echo "📁 Copying default .env.sh"
	cp $< $@

lib: shard.yml shard.lock
	@echo "📦 Installing packages"
	shards install

.PHONY: build
build: bin/gitlabenv ## Build the project
bin/gitlabenv: lib src/*.cr
	@echo "⚒  Building gitlabenv"
	# Because otherwise it won't find libssl correctly on macOS.
	# See this anwswer (NOT the Highest-rated, brew provide the right dependency):
	# https://github.com/crystal-lang/crystal/issues/6875#issuecomment-424959060
	export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig
	shards build

.PHONY: run
run: ## Run gitlabenv, args: id="my/project/path"
run: bin/gitlabenv
	@$(source)
	@./$< $(id)

.PHONY: clean
clean:  ## Clean the build
	@echo "🗑  Clean the build"
	rm -rf bin
	rm -rf lib

# This command checks for any target that end in comment with `##`, extract the
# target and command, and print it as help.  Any target without a `##` comment
# won't show up in the help.
help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

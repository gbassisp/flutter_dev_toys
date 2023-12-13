# ensure target stops if there is an error; run on a single shell
# .ONESHELL:
# SHELL = /usr/bin/perl
# .SHELLFLAGS = -e

# check if fvm command exists, otherwise use empty string
FVM_CMD := $(shell command -v fvm 2> /dev/null)
DART_CMD := $(FVM_CMD) dart
FLUTTER_CMD := $(FVM_CMD) flutter

export PATH := $(HOME)/.pub-cache/bin:$(PATH)


.PHONY: all
all: clean fix analyze doc test

.PHONY: test
test: get
	@echo "Running tests..."
	$(FLUTTER_CMD) test --test-randomize-ordering-seed=random

.PHONY: get
get:
	@echo "Checking version..."
	$(FLUTTER_CMD) --version
	@echo "Getting dependencies..."
	$(FLUTTER_CMD) pub get 
	$(FLUTTER_CMD) gen-l10n
	$(DART_CMD) format lib/l10n/arb --line-length 80

.PHONY: clean
clean: get
	$(FLUTTER_CMD) clean
	$(MAKE) get

.PHONY: doc
doc:
	@echo "Generating documentation..."
	@$(DART_CMD) doc || echo "Failed to generate documentation - maybe it's dart 2.12?"

.PHONY: analyze
analyze:
	@echo "Analyzing..."
	$(DART_CMD) analyze --fatal-infos --fatal-warnings
	$(DART_CMD) format --set-exit-if-changed .

.PHONY: fix
fix:
	@echo "Fixing..."
	$(DART_CMD) format lib test . --line-length 80
	$(DART_CMD) fix --apply



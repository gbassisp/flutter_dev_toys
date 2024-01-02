# ensure target stops if there is an error; run on a single shell
# .ONESHELL:
# SHELL = /usr/bin/perl
# .SHELLFLAGS = -e

# check if fvm command exists, otherwise use empty string
FVM_CMD := $(shell command -v fvm 2> /dev/null)
DART_CMD := $(FVM_CMD) dart
FLUTTER_CMD := $(FVM_CMD) flutter

export PATH := $(HOME)/.pub-cache/bin:$(PATH)


.PHONY: all --basic
all: --basic doc
--basic: clean fix analyze test

.PHONY: test
test: get
	@echo "Running tests..."
	$(FLUTTER_CMD) test --test-randomize-ordering-seed=random

.PHONY: l10n
l10n:
	$(FLUTTER_CMD) gen-l10n
	$(DART_CMD) format lib/l10n/arb --line-length 80

.PHONY: get
get:
	@echo "Checking version..."
	$(FLUTTER_CMD) --version
	@echo "Getting dependencies..."
	$(FLUTTER_CMD) pub get 
	$(MAKE) l10n

.PHONY: generate
generate: get
	$(DART_CMD) run build_runner build --delete-conflicting-outputs

.PHONY: clean
clean: get
	$(FLUTTER_CMD) clean
	$(MAKE) generate

.PHONY: doc
doc:
	@echo "Generating documentation..."
	@$(DART_CMD) doc || echo "Failed to generate documentation - maybe it's dart 2.12?"

.PHONY: analyze analyse lint analysis # main is always the first one
lint: analyze
analysis: analyze
analyse: analyze
analyze:
	@echo "Analyzing..."
	$(DART_CMD) analyze --fatal-infos --fatal-warnings
	$(DART_CMD) format --set-exit-if-changed .

.PHONY: fix
fix:
	@echo "Fixing..."
	$(DART_CMD) format lib test . --line-length 80
	$(DART_CMD) fix --apply


# Build chrome extension:
.PHONY: chrome-extension chrome extension # Either of these targets are acceptable
chrome-extension: chrome
extension: chrome
chrome: --basic
	$(FLUTTER_CMD) build web --web-renderer html --csp --release


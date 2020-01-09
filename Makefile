COMMON := nodes/common.json
BUNDLE_PATH := vendor/bundle

all: Gemfile.lock

update: ghr $(COMMON)

ghr:
	which ghr || go get -u -v github.com/yowcow/ghr

$(COMMON): $(COMMON).in .current-neovim .current-tmux
	cat $< \
		| sed -e 's/__NEOVIM__/$(shell cat .current-neovim)/' \
		| sed -e 's/__TMUX__/$(shell cat .current-tmux)/' \
		> $@

.current-neovim:
	ghr -repo neovim/neovim | grep '^v' | head -n1 | sed -e 's/^v//' > $@

.current-tmux:
	ghr -repo tmux/tmux | head -n1 > $@

Gemfile.lock: Gemfile
	bundle config set path $(BUNDLE_PATH)
	bundle install

HOSTNAME := $(shell hostname)

ifeq ($(HOSTNAME),my-bionic)
ROLE ?= vagrant
else ifeq ($(HOSTNAME),dev03-bco)
ROLE ?= server
else ifeq ($(HOSTNAME),machine-4)
ROLE ?= laptop
else
ROLE ?=
endif

apply: roles/$(ROLE)

roles/%:
	bundle config set path $(BUNDLE_PATH)
	ENVNAME=$* bundle exec -- \
	itamae local --node-json=$(COMMON) \
	roles/$*.rb

clean:
	rm -rf $(COMMON) .current-*

realclean: clean
	rm -rf Gemfile.lock vendor

.PHONY: all update ghr apply roles/* clean realclean

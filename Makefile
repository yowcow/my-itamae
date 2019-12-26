COMMON := nodes/common.json

CURRENT_VIM := .current-vim
CURRENT_NVIM := .current-nvim

all: Gemfile.lock

update: ghr $(CURRENT_VIM) $(CURRENT_NVIM) $(COMMON)

ghr:
	which ghr || go get github.com/yowcow/ghr

$(CURRENT_VIM):
	ghr -repo vim/vim | grep '^v' | head -n1 | sed -e 's/^v//' > $@

$(CURRENT_NVIM):
	ghr -repo neovim/neovim | grep '^v' | head -n1 | sed -e 's/^v//' > $@

$(COMMON): $(COMMON).in
	cat $< \
		| sed -e 's/%%VIM_VERSION%%/$(shell cat $(CURRENT_VIM))/' \
		| sed -e 's/%%NVIM_VERSION%%/$(shell cat $(CURRENT_NVIM))/' \
		> $@

Gemfile.lock: Gemfile
	bundle config set path 'vendor/bundle'
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
	ENVNAME=$* bundle exec -- \
	itamae local --node-json=$(COMMON) \
	roles/$*.rb

clean:
	rm -rf $(CURRENT_VIM) $(CURRENT_NVIM) $(COMMON)

realclean: clean
	rm -rf Gemfile.lock vendor

.PHONY: all update apply roles/* clean realclean

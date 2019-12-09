COMMON := nodes/common.json

CURRENT_VIM := .current-vim
CURRENT_NVIM := .current-nvim

all: Gemfile.lock ghr $(CURRENT_VIM) $(CURRENT_NVIM) $(COMMON)

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
	bundle install --path vendor/bundle

HOSTNAME := $(shell hostname)

ifeq ($(HOSTNAME),my-bionic)
ROLE ?= vagrant
else ifeq ($(HOSTNAME),www12471ui)
ROLE ?= sakura
else ifeq ($(HOSTNAME),machine-4)
ROLE ?= galago
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

.PHONY: all apply roles/* clean realclean

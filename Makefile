COMMON := nodes/common.json

CURRENT_VIM := .current-vim
CURRENT_NVIM := .current-nvim

all: Gemfile.lock ghr $(CURRENT_VIM) $(CURRENT_NVIM) $(COMMON)

ghr:
	which ghr || go get github.com/yowcow/ghr

$(CURRENT_VIM):
	ghr -repo vim/vim HEAD | sed -e 's/^v//' > $@

$(CURRENT_NVIM):
	head=$$(ghr -repo neovim/neovim HEAD) && \
	if [ "$$head" = "nightly" ]; then \
		ghr -repo neovim/neovim HEAD^ | sed -e 's/^v//' > $@; \
	else \
		echo $$head | sed -e 's/^v//' > $@; \
	fi

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
else ifeq ($(HOSTNAME),machine3)
ROLE ?= machine3
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

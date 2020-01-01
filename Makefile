COMMON := nodes/common.json

all: Gemfile.lock

update: ghr $(COMMON)

ghr:
	which ghr || go get -u -v github.com/yowcow/ghr

$(COMMON): $(COMMON).in .current-vim .current-neovim .current-tmux
	cat $< \
		| sed -e 's/__VIM__/$(shell cat .current-vim)/' \
		| sed -e 's/__NEOVIM__/$(shell cat .current-neovim)/' \
		| sed -e 's/__TMUX__/$(shell cat .current-tmux)/' \
		> $@

.current-vim:
	ghr -repo vim/vim | grep '^v' | head -n1 | sed -e 's/^v//' > $@

.current-neovim:
	ghr -repo neovim/neovim | grep '^v' | head -n1 | sed -e 's/^v//' > $@

.current-tmux:
	ghr -repo tmux/tmux | head -n1 > $@

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
	rm -rf $(COMMON) .current-*

realclean: clean
	rm -rf Gemfile.lock vendor

.PHONY: all update ghr apply roles/* clean realclean

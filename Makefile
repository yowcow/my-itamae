.PHONY: all roles/* clean realclean

ENVS = sakura vagrant
COMMON = nodes/common.json

CURRENT_VIM = .current-vim
CURRENT_NVIM = .current-nvim

all: Gemfile.lock ghr $(CURRENT_VIM) $(CURRENT_NVIM) $(COMMON)

ghr:
	which ghr || go get github.com/yowcow/ghr

$(CURRENT_VIM):
	ghr -repo vim/vim HEAD | sed -e 's/^v//' > $@

$(CURRENT_NVIM):
	head=$$(ghr -repo neovim/neovim HEAD) && \
	if [ "$$head" = "nightly" ]; then \
		ghr -repo neovim/neovim HEAD^ > $@; \
	else \
		echo $$head > $@; \
	fi

$(COMMON): $(COMMON).tmpl
	cat $< \
		| sed -e 's/%%VIM_VERSION%%/$(shell cat $(CURRENT_VIM))/' \
		| sed -e 's/%%NVIM_VERSION%%/$(shell cat $(CURRENT_NVIM))/' \
		> $@

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

roles/%: $(COMMON)
	ENVNAME=$* bundle exec -- \
	itamae local --node-json=$< \
	roles/$*.rb

clean:
	rm -rf $(CURRENT_VIM) $(CURRENT_NVIM) $(COMMON)

realclean: clean
	rm -rf Gemfile.lock vendor

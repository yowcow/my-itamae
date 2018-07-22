.PHONY: all roles/* clean realclean

ENVS = sakura vagrant
COMMON = nodes/common.json

CURRENT_VIM = .current-vim

all: ghr Gemfile.lock .current-vim $(COMMON)

ghr:
	which ghr || go get github.com/yowcow/ghr

$(CURRENT_VIM):
	ghr -repo vim/vim HEAD > $@

$(COMMON): $(COMMON).tmpl
	cat $< \
		| sed 's/%%VIM_VERSION%%/$(shell cat $(CURRENT_VIM))/' \
		> $@

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

roles/%: $(COMMON)
	ENVNAME=$* bundle exec -- \
	itamae local --node-json=$< \
	roles/$*.rb

clean:
	rm -rf $(CURRENT_VIM) $(COMMON)

realclean: clean
	rm -rf Gemfile.lock vendor

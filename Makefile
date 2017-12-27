.PHONY: all roles/* clean realclean

ENVS = sakura vagrant
COMMON = nodes/common.json

all: Gemfile.lock .vim-ver $(COMMON)

.vim-ver:
	which vim-ver || go get github.com/yowcow/vim-ver && go install github.com/yowcow/vim-ver
	vim-ver HEAD > $@

$(COMMON): $(COMMON).tmpl
	cat $< \
		| sed 's/%%VIMVER%%/$(shell cat .vim-ver)/' \
		> $@

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

roles/%: $(COMMON)
	sudo -H ENVNAME=$* bundle exec -- \
	itamae local --node-json=$< \
	roles/$*.rb

clean:
	rm -rf .vim-ver $(COMMON)

realclean: clean
	rm -rf Gemfile.lock vendor

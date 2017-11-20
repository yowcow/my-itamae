.PHONY: all env/* clean realclean

ENVS = sakura vagrant
COMMON = nodes/common.json

all: Gemfile.lock $(COMMON)
	sudo apt-get update

$(COMMON): $(COMMON).tmpl
	which vim-ver || go get github.com/yowcow/vim-ver && go install github.com/yowcow/vim-ver
	cat $< | sed 's/%%VIMVER%%/$(shell vim-ver HEAD)/' > $@

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

roles/%: Gemfile.lock $(COMMON)
	sudo -H ENVNAME=$* bundle exec -- \
	itamae local --node-json=$(COMMON) \
	roles/$*.rb

clean:
	rm -rf $(COMMON)

realclean: clean
	rm -rf Gemfile.lock vendor

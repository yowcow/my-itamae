.PHONY: sakura vagrant clean realclean

COMMON = nodes/common.json

all: Gemfile.lock $(COMMON)

$(COMMON): $(COMMON).tmpl
	which vim-ver || go get github.com/yowcow/vim-ver && go install github.com/yowcow/vim-ver
	cat $< | sed 's/%%VIMVER%%/$(shell vim-ver HEAD)/' > $@

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

sakura: Gemfile.lock $(COMMON)
	sudo -H ENVNAME=$@ bundle exec -- \
	itamae local --node-json=$(COMMON) \
	roles/$@.rb

vagrant: Gemfile.lock $(COMMON)
	sudo -H ENVNAME=$@ bundle exec -- \
	itamae local --node-json=$(COMMON) \
	roles/$@.rb

clean:
	rm -rf $(COMMON)

realclean: clean
	rm -rf Gemfile.lock vendor

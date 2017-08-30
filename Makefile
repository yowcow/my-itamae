.PHONY: sakura vagrant clean realclean

COMMON = nodes/common.json
COMMON_TMPL = nodes/common.json.tmpl

all: Gemfile.lock $(COMMON)

$(COMMON):
	which vim-ver || go get github.com/yowcow/vim-ver && go install github.com/yowcow/vim-ver
	cat $(COMMON_TMPL) | sed 's/%%VIMVER%%/$(shell vim-ver HEAD)/' > $(COMMON)

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

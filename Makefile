.PHONY: all roles/* clean realclean

ENVS = sakura vagrant
COMMON = nodes/common.json

all: Gemfile.lock .vimver $(COMMON)

.vimver:
	which ghr || go get github.com/yowcow/ghr
	ghr -repo vim/vim HEAD > $@

$(COMMON): $(COMMON).tmpl
	cat $< \
		| sed 's/%%VIMVER%%/$(shell cat .vimver)/' \
		> $@

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

roles/%: $(COMMON)
	ENVNAME=$* bundle exec -- \
	itamae local --node-json=$< \
	roles/$*.rb

clean:
	rm -rf .vimver $(COMMON)

realclean: clean
	rm -rf Gemfile.lock vendor

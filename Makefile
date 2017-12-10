.PHONY: all roles/* clean realclean

ENVS = sakura vagrant
COMMON = nodes/common.json

all: Gemfile.lock .vim-ver nodes/xenial.json nodes/artful.json

.vim-ver:
	which vim-ver || go get github.com/yowcow/vim-ver && go install github.com/yowcow/vim-ver
	vim-ver HEAD > $@

nodes/%.json: $(COMMON).tmpl
	cat $< \
		| sed 's/%%VIMVER%%/$(shell cat .vim-ver)/' \
		| sed 's/%%RELEASE%%/$*/' \
		> $@

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

roles/sakura: Gemfile.lock nodes/xenial.json
	sudo -H ENVNAME=sakura bundle exec -- \
	itamae local --node-json=nodes/xenial.json \
	roles/sakura.rb

roles/vagrant: Gemfile.lock nodes/xenial.json
	sudo -H ENVNAME=vagrant bundle exec -- \
	itamae local --node-json=nodes/xenial.json \
	roles/vagrant.rb

roles/galago: Gemfile.lock nodes/xenial.json
	sudo -H ENVNAME=galago bundle exec -- \
	itamae local --node-json=nodes/artful.json \
	roles/galago.rb

clean:
	rm -rf .vim-ver nodes/xenial.json nodes/artful.json

realclean: clean
	rm -rf Gemfile.lock vendor

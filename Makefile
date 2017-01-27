.PHONY: server

all: Gemfile.lock

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

sakura: Gemfile.lock
	sudo bundle exec -- \
	itamae local --node-json=nodes/common.json \
	roles/$@.rb

vagrant: Gemfile.lock
	sudo bundle exec -- \
	itamae local --node-json=nodes/common.json \
	roles/$@.rb

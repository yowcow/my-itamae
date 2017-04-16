.PHONY: sakura vagrant

all: Gemfile.lock

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

sakura: Gemfile.lock
	sudo -H ENVNAME=$@ bundle exec -- \
	itamae local --node-json=nodes/common.json \
	roles/$@.rb

vagrant: Gemfile.lock
	sudo -H ENVNAME=$@ bundle exec -- \
	itamae local --node-json=nodes/common.json \
	roles/$@.rb

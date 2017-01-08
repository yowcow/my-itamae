.PHONY: vagrant

all: Gemfile.lock

Gemfile.lock: Gemfile
	bundle install --path vendor/bundle

vagrant: Gemfile.lock
	sudo bundle exec -- \
	itamae local --node-json=nodes/common.json \
	roles/vagrant.rb

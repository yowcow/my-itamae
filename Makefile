.PHONY: local circle help

all:
	bundle install --deployment

local:
	sudo bundle exec -- \
	itamae local --node-json=nodes/my.json \
	roles/essential.rb \
	roles/server-env.rb \
	roles/my/app.rb

circle:
	sudo bundle exec -- \
	itamae local --node-json=nodes/my-circle.json \
	roles/essential.rb \
	roles/my/app.rb

help:
	cat Makefile

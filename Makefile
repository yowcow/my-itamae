.PHONY: dev-remote dev-local

all: usage

usage:
	@echo "Usage: make <target>"

dev-local:
	sudo itamae local --node-json=node.json roles/dev.rb

dev-remote:
	itamae ssh --node-json=node.json --host=192.168.33.10 --user=vagrant roles/dev.rb

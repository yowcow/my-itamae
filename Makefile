.PHONY: dev

all: usage

usage:
	@echo "Usage: make <target>"

dev:
	itamae ssh --node-json=node.json --host=192.168.33.10 --user=vagrant roles/dev.rb

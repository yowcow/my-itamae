IMAGE = my-itamae

all:
	$(MAKE) -f dev.mk -j 2 build/vagrant

build/%:
	docker build -t $(IMAGE):$* .

run:
	$(MAKE) -f dev.mk -j 2 run/vagrant

run/%:
	docker run --rm \
		$(IMAGE):$* \
		sh -c 'make realclean && make && make roles/$*'

.PHONY: all build/* run run/*

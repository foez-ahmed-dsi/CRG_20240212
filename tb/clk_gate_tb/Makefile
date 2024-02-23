TOP = $(shell basename $(PWD))
FLIST = $(shell cat flist)
CLEAN_TARGETS = $(shell cat ../../.gitignore)

run:
	@xvlog -i ../../include -sv $(FLIST)
	@xelab $(TOP) -s top
	@xsim top -runall

clean:
	@rm -rf $(CLEAN_TARGETS)

.PHONY: simulate
simulate: 
	@echo "$(TOP)" > ___TOP
	$(MAKE) clean run TOP=$(TOP) CONFIG=$(CONFIG)

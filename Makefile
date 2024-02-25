TBS = $(shell ls tb)

.PHONY:all
all: clean
	@$(foreach tb, $(TBS), pushd tb/$(tb) && make && popd;)
	@make --no-print-directory print
	@make --no-print-directory clean

.PHONY: print
print:
	@echo ""
	@$(eval logfiles = $(shell find $(realpath ./) -name "xsim.log"))
	@$(foreach file, $(logfiles), cat $(file) | grep "\[PASS\]\|\[FAIL\]";)
	@echo ""

.PHONY:clean
clean: temp/clean_targets
	@$(eval CLEAN_TARGETS = $(shell cat temp/clean_targets))
	@rm -rf temp
	@echo "REMOVING: temp $(CLEAN_TARGETS)"
	@rm -rf $(CLEAN_TARGETS)
	
.PHONY: temp clean_targets
temp/clean_targets:
	@$(eval CLEAN_TARGETS_TYPE = $(shell cat .gitignore))
	@rm -rf temp
	@mkdir -p temp
	@$(foreach type, $(CLEAN_TARGETS_TYPE), find -name "$(type)" >> temp/clean_targets;)

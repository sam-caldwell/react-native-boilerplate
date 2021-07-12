.PHONY: pre-check

pre-check:
	@echo "pre-check says..."
ifneq ("$(wildcard ./setup.log)","")
	@echo ""
	@echo "setup already run.  use clean_setup first"
	@echo ""
	exit 1
else
	@echo "ok to run."
endif
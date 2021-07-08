.PHONY: pre-check

pre-check:
ifneq ("$(wildcard ./setup.log)","")
	@echo ""
	@echo "setup already run.  use setup_clean first"
	@echo ""
	exit 1
endif
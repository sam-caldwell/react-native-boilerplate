.PHONY: pre-check

pre-check:
	@echo "pre-check says..."
ifneq ("$(wildcard ./setup.log)","")
	@echo ""
	@echo "setup already run.  use setup_clean first"
	@echo ""
	exit 1
else
	@echo "ok to run."
endif
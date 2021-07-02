.PHONY: help

help:
	@echo ""
	@echo "This Makefile includes several specific files located in "
	@echo "Makefile.d/*.mk"
	@echo ""

include Makefile.d/*.mk

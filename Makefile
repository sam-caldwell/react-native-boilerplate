.PHONY: help

include Makefile.d/*.mk

help:
	@echo ""
	@echo "Makefile is capable of..."
	@grep '^[^#[:space:]].*:' Makefile | grep -v -i Phony | grep -v -e ^#.*$$ | awk -F \: '{print $$1}'
	@grep '^[^#[:space:]].*:' Makefile.d/*.mk | grep -v -i Phony | grep -v -e ^#.*$$ | awk -F \: '{print $$2}'
	@echo " "

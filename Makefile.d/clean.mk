.PHONY: clean

clean_react_client:
	@rm -rf client
	@mkdir client &> /dev/null || true
	@rm -rf /Users/scaldwell/Library/Caches/CocoaPods


clean_log_file:
	@rm -rf ./setup.log

clean_setup: clean_react_client clean_log_file

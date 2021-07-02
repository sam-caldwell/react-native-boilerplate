.PHONY: setup

setup: setup_mac setup_linux setup_windows
	@echo "setup complete"

setup_nix_env_vars:
	@sed -i -e '/### android studio setup start ###/d' ~/.bash_profile
	sed -i -e '/export ANDROID_HOME=\\$HOME\/Library\/Android\/sdk/d' ~/.bash_profile
	sed -i -e '/export PATH=\\$PATH:\\$ANDROID_HOME\/emulator/d' ~/.bash_profile
	sed -i -e '/export PATH=\\$PATH:\\$ANDROID_HOME\/tools/d' ~/.bash_profile
	sed -i -e '/export PATH=\\$PATH:\\$ANDROID_HOME\/tools\/bin/d' ~/.bash_profile
	sed -i -e '/export PATH=\\$PATH:\\$ANDROID_HOME\/platform-tools/d' ~/.bash_profile
	@sed -i -e '/### android studio setup stop ###/d' ~/.bash_profile

	@echo '### android studio setup start ###' >> ~/.bash_profile
	@echo 'export ANDROID_HOME=\\$HOME/Library/Android/sdk' >> ~/.bash_profile
	@echo 'export PATH=\\$PATH:\\$ANDROID_HOME/emulator' >> ~/.bash_profile
	@echo 'export PATH=\\$PATH:\\$ANDROID_HOME/tools' >> ~/.bash_profile
	@echo 'export PATH=\\$PATH:\\$ANDROID_HOME/tools/bin' >> ~/.bash_profile
	@echo 'export PATH=\\$PATH:\\$ANDROID_HOME/platform-tools' >> ~/.bash_profile
	@echo '### android studio setup stop ###' >> ~/.bash_profile

setup_mac: setup_nix_env_vars
	command -v brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@echo "brew is installed"
	brew update
	command -v node --version || brew install node
	brew install watchman
	# ios specifics
	xcode-select --install
	sudo gem install cocoapods
	# android specifics
	brew install --cask adoptopenjdk/openjdk/adoptopenjdk11

setup_linux: setup_nix_env_vars
	@echo "linux not implemented"

setup_windows:
	@echo "windows not implemented"

THIS_DIRECTORY=$(shell basename $$(pwd -P))
setup_react:
	@echo "Project: '${THIS_DIRECTORY}'"
	npx react-native init -y ${THIS_DIRECTORY}

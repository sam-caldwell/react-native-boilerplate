.PHONY: setup

THIS_DIRECTORY=$(shell basename $$(pwd -P))

setup: setup_mac setup_react_client
	@echo "setup complete"

setup_linux: setup_nix_env_vars
	@echo "linux not implemented"

setup_windows:
	@echo "windows not implemented"

setup_mac: setup_nix_env_vars
	command -v brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@echo "brew is installed"
	@brew update
	@command -v node --version || brew install node
	@brew install watchman
	# ios specifics
	@xcode-select --install &> /dev/null || sudo xcode-select --switch /Library/Developer/CommandLineTools/
	@sudo gem install cocoapods
	@sudo gem install xcode-install
	@xcversion simulators --install='iOS 14.4'
	# android specifics
	@brew install --cask adoptopenjdk/openjdk/adoptopenjdk11 || brew reinstall -f adoptopenjdk11

setup_nix_env_vars:
	@echo "cleanup any existing environment variables"
	@sed -i -e '/### android studio setup start ###/d' ~/.bash_profile
	sed -i -e '/export ANDROID_HOME=$$HOME\/Library\/Android\/sdk/d' ~/.bash_profile
	sed -i -e '/export PATH=$$PATH:$$ANDROID_HOME\/emulator/d' ~/.bash_profile
	sed -i -e '/export PATH=$$PATH:$$ANDROID_HOME\/tools/d' ~/.bash_profile
	sed -i -e '/export PATH=$$PATH:$$ANDROID_HOME\/tools\/bin/d' ~/.bash_profile
	sed -i -e '/export PATH=$$PATH:$$ANDROID_HOME\/platform-tools/d' ~/.bash_profile
	@sed -i -e '/### android studio setup stop ###/d' ~/.bash_profile

	@echo "add new environment variables to bash_profile"
	@echo '### android studio setup start ###' >> ~/.bash_profile
	@echo 'export ANDROID_HOME=$$HOME/Library/Android/sdk' >> ~/.bash_profile
	@echo 'export PATH=$$PATH:$$ANDROID_HOME/emulator' >> ~/.bash_profile
	@echo 'export PATH=$$PATH:$$ANDROID_HOME/tools' >> ~/.bash_profile
	@echo 'export PATH=$$PATH:$$ANDROID_HOME/tools/bin' >> ~/.bash_profile
	@echo 'export PATH=$$PATH:$$ANDROID_HOME/platform-tools' >> ~/.bash_profile
	@echo '### android studio setup stop ###' >> ~/.bash_profile
	@echo "...setup_nix_env_vars (done)"

setup_react_client:
	@echo "Project: '${THIS_DIRECTORY}' (client)"
	@(\
	cd client;\
	npx react-native init ${THIS_DIRECTORY} --template react-native-template-typescript || true;\
	cd ./simpleChat/ios && pod install;\
	)

clean_react_client:
	rm -rf client/simpleChat
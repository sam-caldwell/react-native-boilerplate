.PHONY: setup
THIS_DIRECTORY=$(shell basename $$(pwd -P))
APP_NAME=$(shell basename $$(pwd -P))

setup: pre-check rename-repo setup_mac setup_react_client
	@echo "finishing setup"
	@echo "$$(date)" > setup.log
	@echo "setup complete"

setup_linux: setup_nix_env_vars
	@echo "linux not implemented"

setup_windows:
	@echo "windows not implemented"

setup_mac: setup_mac_client setup_mac_server

setup_brew:
	@/usr/bin/command -v brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@echo "brew installed"

setup_mac_server: setup_brew
	@/usr/bin/command -v docker || brew install docker
	@echo "docker installed"
	@/usr/bin/command -v docker-compose || brew install docker-compose
	@echo "docker-compose installed"

setup_mac_client: setup_brew setup_nix_env_vars
	@command -v brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@echo "brew is installed"
	@brew update
	@command -v node --version || brew install node
	@brew install watchman
	# ios specifics
	@xcode-select --install &> /dev/null || sudo sudo xcode-select --switch /Applications/Xcode.app
	@sudo gem install cocoapods
	@sudo gem install xcode-install
	@xcversion simulators --install='iOS 14.4' || true
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
	npx react-native init ${APP_NAME} || true;\
	cd ./${APP_NAME}/ios && pod install;\
	)

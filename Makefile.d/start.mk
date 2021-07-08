.Phony: start start-server start-client start-android start-ios

yarn-install: stop-client
	@(\
		cd client/${APP_NAME} &&\
		rm -rf node_modules &&\
		yarn install &&\
		watchman watch-del-${myArray[@]} &&\
		sh -c 'yarn start --reset-cache &' &&\
        rm -rf /tmp/metro-*;\
	)

start-server:
	@echo "not implemented"
	#ToDo: implement using Docker Compose

start-react: yarn-install
	@(\
		cd client/${APP_NAME};\
		npx react-native start;\
	)

start-ios: yarn-install
	@(\
		cd client/${APP_NAME};\
		sh -c 'sleep 5; npx react-native run-ios &';\
	)

start-android: yarn-install
	@(\
		cd client/${APP_NAME};\
		emulator -avd Pixel_XL_API_27 &; \
		sh -c 'sleep 5; npx react-native run-android &';\
	)

.Phony: start start-server start-client start-android start-ios

start: start-server start-client
	@echo "client and server are started."

start-server:
	@echo "not implemented"
	#ToDo: implement using Docker Compose

start-client: start-ios start-android start-react
	@echo "client is started"


start-react:
	@(\
		cd client/simpleChat;\
		npx react-native start;\
	)

start-ios:
	@(\
		cd client/simpleChat;\
		sh -c 'sleep 5; npx react-native run-ios &';\
	)

start-android:
	@(\
		cd client/simpleChat;\
		emulator -avd Pixel_XL_API_27 &; \
		sh -c 'sleep 5; npx react-native run-android &';\
	)

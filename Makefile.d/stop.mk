.Phony: stop stop-client stop-android stop-ios

stop: stop-client stop-server
	@echo "client and server are stopped"

stop-server:
	@echo "not implemented"
	#ToDo: implement using Docker Compose

stop-client: stop-android stop-ios stop-react
	@echo "client is stopped."

stop-react:
	@(\
		cd client/simpleChat;\
		npx react-native stop;\
	)

stop-ios:
	@(\
		cd client/simpleChat;\
		npx react-native stop-ios;\
	)

stop-android:
	@(\
		cd client/simpleChat;\
		npx react-native stop-android;\
	)

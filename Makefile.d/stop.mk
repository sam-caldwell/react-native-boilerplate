.Phony: stop stop-client stop-android stop-ios

stop: stop-client stop-server
	@echo "client and server are stopped"

CLIENT_PID=$(shell ps aux | grep -v grep | grep ${APP_NAME} | awk '{print $$2}')

stop-client:
	@kill -9 ${CLIENT_PID} &> /dev/null || true
	@echo "stopped."


stop-server:
	@echo "not implemented"
	#ToDo: implement using Docker Compose

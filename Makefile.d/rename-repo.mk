.PHONY: rename-repo

rename-repo:
	@echo "rename-repo starting"
	@(\
		read -p "Enter the name of your project: " REPO_NAME;\
		echo "creating {$REPO_NAME}";\
		cd ..;\
		mv react-native-boilerplate ${REPO_NAME};\
		cd ${REPO_NAME};\
		rm -rf .git;\
		git init .;\
		echo "a new local git repo is created for ${REPO_NAME}";\
		git add -A .;\
		git commit -m "initial commit";\
		echo "You'll need to create the repo for ${REPO_NAME} in github/bitbucket and push";\
	)
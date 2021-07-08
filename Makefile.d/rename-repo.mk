.PHONY: rename-repo

rename-repo:
	@echo "rename-repo starting"
	@read -p "Enter the name of your project: " REPO_NAME;\
	echo "creating $${REPO_NAME}";\
	cd ..;\
	rsync -avr --exclude=.git react-native-boilerplate/* $${REPO_NAME};\
	cd $${REPO_NAME};\
	pwd;\
	echo "removing the old repo";\
	rm -rf .git;\
	echo "configuring a new local git repo";\
	git config --global init.defaultBranch main;\
	git init .;\
	echo "====files===start====";\
	ls;\
	echo "====files===end======";\
	echo "a new local git repo is created for '$${REPO_NAME}'";\
	git add -A .;\
	git commit -m "initial commit";\
	echo "You'll need to create the repo for $${REPO_NAME} in github/bitbucket and push"
	pwd
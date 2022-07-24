#!/bin/bash

#Colors
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

#check if arguments are empty
if [ $# -eq 0 ];  then
	echo "No arguments provided."
	read -p 'Enter the directory path: ' targetDir;
else
	targetDir=$1
fi

currentPath=$(pwd)
echo "Current path is: ${currentPath}"
newDir=${currentPath}/${targetDir}

#check if target directory already exists
if [[ -d "${newDir}" ]]; then
	printf "${RED}Directory already exists, please provide different path and try again${NC}\n"
	exit 1;
fi

echo "New directory will be created at: ${newDir}"
mkdir -p ${newDir}
cd ${newDir}
echo "Currently inside: $(pwd)"
mkdir pages css fonts images js
touch index.html ./css/index.css

#copy the "ideal" .gitignore file
GITIGNORE_PATH="${HOME}/Projects/Web/trivia/gitignore-ideal/.gitignore"
#check if .gitignore file exists on local machine
if [ ! -f "${GITIGNORE_PATH}" ]; then
	printf "${ORANGE}Gitignore file is not present by specified path, downloading from the Internet...${NC}\n"
	curl -O "https://gist.githubusercontent.com/salcode/10017553/raw/.gitignore"
else
	cp ${GITIGNORE_PATH} .
fi

echo "-------------------------"
echo "Created files: $(ls -R)"
echo "Please, verify. Opening in vscode in 1s..."
echo "-------------------------"
sleep 1s
codium .

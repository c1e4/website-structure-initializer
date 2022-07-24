#!/bin/bash

#Colors
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
#LIGHT_MAGENTA="\e[95m"
#LIGHT_CYAN="\e[96m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
NC="\e[0m" #No Color


#check if arguments are empty
if [ $# -eq 0 ];  then
	echo "No arguments provided."
	read -p 'Enter the directory path: ' targetDir;
else
	targetDir=$1
fi

currentPath=$(pwd)
#echo "Current path is: ${currentPath}"
newDir=${currentPath}/${targetDir}

#check if target directory already exists
if [[ -d "${newDir}" ]]; then
	printf "${RED}Directory already exists, please provide different path and try again${NC}\n"
	exit 1;
fi

echo -e "${CYAN}-----${NC}${MAGENTA}-----${NC}"
echo -e "${MAGENTA} STAGE #1. CREATE PROJECT DIRECTORY ${NC}"
echo -e "${MAGENTA}-----${NC}${CYAN}-----${NC}"

echo -e "${CYAN}New directory will be created at: ${newDir}${NC}"
mkdir -p ${newDir}

#check if target directory cannot be created
if [ ! -d "${newDir}" ]; then
	printf "${RED}Cannot create project directory, abort${NC}\n"
	exit 1;
else
	#	echo -e "${CYAN}-----${ENDCOLOR}${MAGENTA}-----${ENDCOLOR}"
	#	echo -e " STAGE #1. CREATE PROJECT DIRECTORY: ${GREEN}GOOD${NC}"
	#	echo -e "${MAGENTA}-----${ENDCOLOR}${CYAN}-----${ENDCOLOR}"

	echo ""
	#echo -e "${CYAN}-----${ENDCOLOR}${MAGENTA}-----${ENDCOLOR}"
	echo -e "${CYAN}\tSTATUS:${NC} ${GREEN}GOOD${NC}\n"
	#echo -e "${MAGENTA}-----${ENDCOLOR}${CYAN}-----${ENDCOLOR}"

fi

#cd ${newDir}
#echo "Currently inside: $(pwd)"

echo -e "${CYAN}-----${NC}${MAGENTA}-----${NC}"
echo -e "${MAGENTA} STAGE #2. CREATE INNER STRUCTURE ${NC}"
echo -e "${MAGENTA}-----${ENDCOLOR}${CYAN}-----${ENDCOLOR}"

cd ${newDir}
#echo "Currently inside: $(pwd)"

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

#predictable output of ls -a when directory populated
FILES_INSIDE=9

#check if inner structure has been created
acutalNumberOfFiles=$(ls -a | wc -l)
if [ ${acutalNumberOfFiles} -ne ${FILES_INSIDE} ]; then
	printf "${RED}Cannot create inner structure, abort${NC}\n"
	exit 1;
else
	echo ""
	#	echo -e "${CYAN}-----${ENDCOLOR}${MAGENTA}-----${ENDCOLOR}"
	#echo -e "\tSTATUS: ${GREEN}GOOD${NC}\n"
	echo -e "${CYAN}\tSTATUS:${NC} ${GREEN}GOOD${NC}\n"
	#echo -e "${MAGENTA}-----${ENDCOLOR}${CYAN}-----${ENDCOLOR}"
fi

#echo "-------------------------"
echo -e "${CYAN}-----${NC}${MAGENTA}-----${NC}"
echo -e "${MAGENTA} STAGE #3. ADD GIT INTEGRATION${NC}"
echo -e "${MAGENTA}-----${NC}${CYAN}-----${NC}"
echo -e "${CYAN}"

git init
git add .
git commit -m "Init commit"
GIT_READY_MSG="On branch master
nothing to commit, working tree clean"
gitActualMsg=$(git status)

echo -e "${NC}"

if [ "${gitActualMsg}" = "${GIT_READY_MSG}" ]; then
	printf "${GREEN}Git successfully initialized${NC}\n"
	echo""
	echo -e "${CYAN}\tSTATUS:${NC} ${GREEN}GOOD${NC}\n"
	#echo -e "${MAGENTA}-----${ENDCOLOR}${CYAN}-----${ENDCOLOR}"
else
	printf "${RED}Something went wrong with git initialization${NC}\n"
fi

echo -e "${CYAN}Opening in codium...${NC}"
codium .

#echo "-------------------------"
echo -e "${CYAN}-----${NC}${MAGENTA}-----${NC}"
echo "GOOD LUCK!" | lolcat
echo -e "${MAGENTA}-----${NC}${CYAN}-----${NC}"

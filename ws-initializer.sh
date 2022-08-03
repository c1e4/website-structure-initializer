#!/bin/bash

#Initial directory (script file location)
SCRIPT_DIR=$(pwd)
echo "${SCRIPT_DIR}"

#Colors
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
NC="\e[0m" #No Color

#######################################
# Function that initializes html, css and js with predefined templates
# Globals:
# Arguments:
# Outputs:
#   Writes location to stdout
#######################################

initialize_components_with_templates() {
	cat ${SCRIPT_DIR}/templates/html >| $1/index.html
	cat ${SCRIPT_DIR}/templates/css >|  $1/css/style.css
	cat ${SCRIPT_DIR}/templates/css >|  $1/scss/style.scss
	cat ${SCRIPT_DIR}/templates/js >|   $1/js/script.js
}

#check if arguments are empty
if [ $# -eq 0 ];  then
	echo "No arguments provided."
	read -p 'Enter the directory path: ' targetDir;
else
	newDir=$1
fi

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
	echo ""
	echo -e "${CYAN}\tSTATUS:${NC} ${GREEN}GOOD${NC}\n"
fi

echo -e "${CYAN}-----${NC}${MAGENTA}-----${NC}"
echo -e "${MAGENTA} STAGE #2. CREATE INNER STRUCTURE ${NC}"
echo -e "${MAGENTA}-----${ENDCOLOR}${CYAN}-----${ENDCOLOR}"

cd ${newDir}
#echo "Currently inside: $(pwd)"

mkdir pages css fonts images js scss
touch index.html ./css/style.css ./js/script.js ./scss/style.scss 

#Invoking function to initialize components with template values
currentPath=$(pwd)
initialize_components_with_templates ${currentPath}

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
FILES_INSIDE=10

#check if inner structure has been created
acutalNumberOfFiles=$(ls -a | wc -l)
if [ ${acutalNumberOfFiles} -ne ${FILES_INSIDE} ]; then
	printf "${RED}Cannot create inner structure, abort${NC}\n"
	exit 1;
else

	printf "${CYAN}Project's innner structure established${NC}\n"
	echo ""
	echo -e "${CYAN}\tSTATUS:${NC} ${GREEN}GOOD${NC}\n"
fi

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
	#printf "${GREEN}Git successfully initialized${NC}\n"
	echo -e "${CYAN}\tSTATUS:${NC} ${GREEN}GOOD${NC}\n"
else
	printf "${RED}Something went wrong with git initialization${NC}\n"
fi

echo -e "${CYAN}Opening in codium...${NC}\n"
codium .

echo -e "${CYAN}-----${NC}${MAGENTA}-----${NC}"
echo -e "GOOD LUCK!" | lolcat
echo -e "${MAGENTA}-----${NC}${CYAN}-----${NC}\n"

# website-structure-initializer
Bash script that creates a structure of a website in one simple move with style!. 

Note: the script somewhat depends on `lolcat`, a cool command-line utility for text colorization. It will work without just fine, but make sure to install it for the best experience.

**Problem:**
When I was creating websites, I caught myself doing the same thing over and over:
- create project directory
- populate it with directories for main components (css, js, images, etc)
- create index.html and corresponding styles file.
- add .gitignore
- initialize the project in git and make the first commit 

Thus the idea of this simple yet extremely useful script was conceived. The main goal is to reduce an initial effort (may call it "traction") and save time when creating new web project. Instead of manually creating the same thing over and over (which is tedious and extremely boring), just invoke the script and provide the desired name (path) of project directory. The script will do the rest.   

**How it works:**
1) Create and check whether the project directory has been successfully created
2) Establish inner structure (css, js, pages, fonts folders) + index.html and corresponding styles file. Pefrorm integrity checks.
3) Add specialized .gitignore (stored in specific directory on my machine), if not present - download knows good .gitignore file for web development (https://salferrarello.com/starter-gitignore-file/
)
4) Initialize git, make initial commit. 

**Installation:** 
1. Clone entire repository or download only the script (ws-initializer.sh):
```
git clone https://github.com/c1e4/website-structure-initializer.git
```
2. Place it in the path directory (~/bin, /usr/bin, etc) to your liking or just somewhere on the system:
```
cp website-structure-initializer/ws-initializer.sh ~/bin
```
3. Invoke it, providing name of project directory (or path, relative or full) like this:
```
script.sh [Project]
ws-initializer.sh Project-Husky (using project directory name)
ws-initializer.sh ~/Projects/Project-Neko (using path to project directory)
```
4. ...
5. ~PROFIT!~ Start coding!

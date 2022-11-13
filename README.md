# gito-cli
A simple package to open local git repositories in the browser. GITO cli applies to the working directory

## Install

```bash
npm install -g @gito/gito-cli
```

## Usage:
```md> 
gito                    (default) Opens the default branch of the origin fetch remote repository.
gito -n <remote name>   Opens the remote repo for specified remote name. 
gito -b <branch name>   Opens the remote repo at specified "branch name".
gito [ -h | --help ]    Shows this message.
```
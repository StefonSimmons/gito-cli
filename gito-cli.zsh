# Open git repos
repo="$(
    git remote -v | # get the remote repositories
    grep -h origin | # get the urls with "origins" only
    grep -h fetch | # get the fetch only
    cut -b 8- | # exclude remote name ("origin")
    cut -d" " -f 1 | # exclude "fetch"
    rev | # reverse
    cut -b 5- | # exclude ".git"
    rev | # reverse it again
    sed "s|"git@"|"https://"|g" | # replace "git@" with "https://"(if repo cloned with SSH)
    sed "s|":"|"/"|2" # replace 2nd occurence of ":" (if repo cloned with SSH)
    )"
if [[ "$1" == "" ]]
then
    open $repo
elif [[ "$1" == "-b" ]]
then
    open "$repo/tree/$2"
elif [[ "$1" == "-n" ]]
then
    repo="$(
        git remote -v | # get the remote repositories
        grep -h $2 | # get the urls with $2 only
        grep -h fetch | # get the fetch only
        cut -b $((${#2}+2))- | # exclude remote name. $(()) wraps the math expression. ${} wraps the nested expressions. #2 gets the length of the $2 argument. all together adds wo the length of the repo name 
        cut -d" " -f 1 | # exclude "fetch"
        rev | # reverse
        cut -b 5- | # exclude ".git"
        rev | # reverse it again
        sed "s|"git@"|"https://"|g" | # replace "git@" with "https://"(if repo cloned with SSH)
        sed "s|":"|"/"|2" # replace 2nd occurence of ":" (if repo cloned with SSH)
        )"
    open $repo
elif [[ "$1" == "-h" || "$1" == "--help" || $("$1" | cut -b -1) != "-" ]]
then
<<comm
GITO cli: Open local git repos in the browser

Copyright Stefon Simmons | stefonsimmons1@gmail.com

Note:                       GITO cli applies to the working directory

Usage:
gito                    (default) Opens the default branch of the origin fetch remote repository.
gito -n <remote name>   Opens the remote repo for specified remote name. 
gito -b <branch name>   Opens the remote repo at specified "branch name".
gito [ -h | --help ]    Shows this message.
comm
fi

#!/bin/bash
# any error, whole script fails
set -e

if [ "`git status -s`" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

# Subtree method here: https://gohugo.io/hosting-and-deployment/hosting-on-github/
echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out deploy branch into public"
git worktree add -B prod public deploy/prod

echo "Building site with Hugo..."
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
    msg="$*"
fi

echo "Updating prod branch with message {$msg}"
cd public && git add --all && git commit -m "$msg" && cd ..

printf "\033[0;32mDeploying updates...\033[0m\n"

# Push source and build repos.
git push -f deploy prod

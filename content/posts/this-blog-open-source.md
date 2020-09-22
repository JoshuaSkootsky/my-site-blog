---
title: 'This Blog Is Open Source'
date: 2020-09-22T15:08:18-04:00
draft: false
---

# Hello, There!

You can find this blog at on my GitHub, [the repo is here](https://github.com/JoshuaSkootsky/my-site-blog).

This blog was written with [Hugo, a Go language static site generator](https://gohugo.io/).

You're probably reading this blog at [joshuaskootsky.com](https://oshuaskootsky.com). I found an old Dreamhost account I had, and decided I would put my website development skills to work and spin up a blog.

There was some work put into getting this up on a standard box, and I'd like to share that with you.

If you take a look at my [deploy script](https://https://github.com/JoshuaSkootsky/my-site-blog/blob/main/deploy-script.sh), you can see the following:

```sh
# Subtree method here: https://gohugo.io/hosting-and-deployment/hosting-on-github/
echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out prod branch into public for deployment..."
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
```

What on earth is going on here?

I've got my remote box specified as a git remote tag, specifically the `deploy` target. For me, that's pointed at [joshuaskootsky.com](https://www.joshuaskootsky.com).

Using [Git Worktrees](https://spin.atomicobject.com/2016/06/26/parallelize-development-git-worktrees/) I can, on my `main` branch keep the `public/` folder in my `.gitignore` file, but maintain a deperate `prod` branch that is rooted in the `public` folder and contains the static site elements that Hugo generates.

I can then use git to orchestrate the deployment of my blog to my actual website. The markdown, styles, and themes that I specify for Hugo to use are kept on the `main` branch, and can be viewed on GitHub - but the static site elements, which are generated programmatically by Hugo, are kept seperate on the `prod` worktree branch. That branch I can deploy to the root of my website on my server, and simply serve up the static assets that you are reading now. Pretty cool and JAM stacky!

# 12 Factor Design and the JAM stack

Hugo follows the 12 Factor app principles. You can see similar language with people talking about [the JAM stack, and Hugo definitely falls into JAM stack territory](https://jamstack.org/best-practices/).

The [Twelve Factor App](https://12factor.net/ 'Twelve Factor App') design principles can be found at [12factor.net](https://12factor.net '12 Factor App Site'). It's really interesting to see how well they aged.

To quote the author, [Adam Wiggins](https://news.ycombinator.com/item?id=21416881 'Comment on Hacker News'):

> I'm the author of 12factor (although really it is an aggregation of the work and insights from many people at Heroku). It continues to surprise and please me that this piece continues to be relevant eight years later—a virtual eternity in software/internet time.
> Fun fact: I debated whether to call it "the Heroku way" or somesuch. Glad I went with a standalone name, feel like that allowed it to take on a life beyond that product. For example I doubt Google would have wanted a page about "Heroku Way app development on GCP" in their documentation. :-)

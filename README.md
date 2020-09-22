[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# Hello and Welcome

This is my blog, currently hosted at [joshuaskootsky.com]. I've open sourced how I build and deploy the site so you can take a look behind the scenes, if you like the blog or want to see more of how I think in code.

# Hugo

Hugo is a static site generator, written in the Go language. What I really like about Hugo is that it follows the 12 Factor app methodology of seperating the code from the build and deploy steps. (To be fair, my deploy-script.sh both builds and deploys my blog).

- [ ] To do: build my own theme in Hugo that I can contribute to the Hugo community

# 12 Factor Design

I mentioned earlier that Hugo follows the 12 Factor app principles. You can see similar language with people talking about the JAM stack, and Hugo definitely falls into JAM stack territory.

The [Twelve Factor App](https://12factor.net/ 'Twelve Factor App') design principles can be found at [12factor.net]. It's really interesting to see how well they aged.

To quote the author, [Adam Wiggins](https://news.ycombinator.com/item?id=21416881 'Comment on Hacker News'):

> I'm the author of 12factor (although really it is an aggregation of the work and insights from many people at Heroku). It continues to surprise and please me that this piece continues to be relevant eight years later—a virtual eternity in software/internet time.
> Fun fact: I debated whether to call it "the Heroku way" or somesuch. Glad I went with a standalone name, feel like that allowed it to take on a life beyond that product. For example I doubt Google would have wanted a page about "Heroku Way app development on GCP" in their documentation. :-)

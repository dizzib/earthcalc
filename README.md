# To build and run locally

## Install global dependencies

* [node.js][nodejs]

* [LiveScript][LiveScript]

## Clone and build

* clone the [repository][repo] from GitHub

The build tasks are written in LiveScript so issue a `task/bootstrap` command to make them runnable.

Now launch the task runner:

* `node _build/task/repl`

A helpful list of commands should appear.

Enter `b.nr` to install the dependencies from npm, then enter `b.fc` to build the project.

You should now be able to run the app locally from `_build/site/index.html`.

[LiveScript]: http://livescript.net/#installation
[nodejs]: http://nodejs.org/download/
[repo]: https://github.com/dizzib/earthcalc

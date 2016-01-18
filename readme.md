# calculation method

![calculation method](./calc-method.png)

# build and run locally

## install global dependencies

* [node.js][nodejs]

* [LiveScript][LiveScript]

## clone and bootstrap project

    $ git clone git@github.com:dizzib/earthcalc.git
    $ ./task/bootstrap      # compile task runner and install npm dependencies

## build and run

    $ node _build/task/repl # launch the task runner
    earthcalc > b.all       # build everything

You should now be able to point your browser at `_build/site/index.html`

[LiveScript]: http://livescript.net/#installation
[nodejs]: http://nodejs.org/download/
[repo]: https://github.com/dizzib/earthcalc

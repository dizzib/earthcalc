Assert = require \assert
Shell  = require \shelljs/global

const BUILD   = \_build
const SITE    = \site
const TASK    = \task

const DIR-ROOT  = pwd!
const DIR-BUILD = "#DIR-ROOT/#BUILD"
const DIR-SITE  = "#DIR-ROOT/#SITE"
const DIR-TASK  = "#DIR-ROOT/#TASK"

module.exports =
  APPNAME: \earthcalc
  dirname:
    SITE : SITE
    TASK : TASK
  dir:
    BUILD: DIR-BUILD
    ROOT : DIR-ROOT
    SITE : DIR-SITE
    TASK : DIR-TASK

Assert test \-e "#DIR-BUILD"
Assert test \-e "#DIR-SITE"
Assert test \-e "#DIR-TASK"

global.log = console.log

Chalk = require \chalk
Rl    = require \readline
Shell = require \shelljs/global
WFib  = require \wait.for .launchFiber
Build = require \./build
Dir   = require \./constants .dir
G     = require \./growl

# for safety, set working directory to build
cd Dir.BUILD

# shelljs doesn't seem to raise exceptions. Next best thing is for this
# process to die on error
config.fatal = true

# flags
build-tests-enabled = true

const COMMANDS =
  * cmd:'h    ' lev:0 desc:'help  - show commands'      fn:show-help
  * cmd:'b.fc ' lev:0 desc:'build - files compile'      fn:Build.compile-files
  * cmd:'b.nr ' lev:0 desc:'build - npm refresh'        fn:Build.refresh-modules

const CHALKS = [Chalk.stripColor, Chalk.yellow, Chalk.red]
for c in COMMANDS
  c.disabled = (c.cmd.0 is \d and not Data.is-cfg!) or (c.cmd.0 is \p and not Prod.is-cfg!)
  c.display = "#{Chalk.bold CHALKS[c.lev] c.cmd} #{c.desc}"

rl = Rl.createInterface input:process.stdin, output:process.stdout
  ..setPrompt "earthcalc >"
  ..on \line, (cmd) -> WFib ->
    switch cmd
    | '' =>
      rl.prompt!
    | _  =>
      for c in COMMANDS when cmd is c.cmd.trim! then try-fn c.fn
      rl.prompt!

Build.start!
setTimeout show-help, 1000ms

# helpers

function show-help
  bt = if build-tests-enabled then Chalk.bold.green \yes else Chalk.bold.cyan \no
  for c in COMMANDS when !c.disabled then log c.display.replace \$BT, bt
  rl.prompt!

function try-fn
  try it!
  catch e then log e

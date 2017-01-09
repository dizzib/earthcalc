Chalk = require \chalk
G     = require \growly
Util  = require \util
Const = require \./constants

const CHALKS = error:Chalk.red, info:Chalk.stripColor, success:Chalk.green
enabled = (growl-at = process.env.growl-at)?

function send label, item, opts = {}
  text = Chalk.stripColor if item instanceof Error then item.message else item
  Util.log CHALKS[label] text unless opts.nolog
  return unless enabled
  title = "#{Const.APPNAME} #label".toUpperCase!
  # for some reason a '::' causes the growl to fail !?
  err <- G.notify (text.replace /::/g \:), (label:label, title:title) <<< opts
  log err if err

module.exports =
  alert: (err, opts)  -> send \error err, (sticky:true) <<< opts
  err  : (err, opts)  -> send \error err, opts
  ok   : (text, opts) -> send \success text, opts
  say  : (text, opts) -> send \info text, opts

return log "growl disabled" unless enabled
log "growl at #growl-at"

G.setHost growl-at
err <- G.register Const.APPNAME, [{label:\error} {label:\info} {label:\success}]
log err if err

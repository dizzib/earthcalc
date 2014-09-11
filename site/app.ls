# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

const FEET-PER-MILE    = 5280ft
const EARTH-RADIUS     = 3959miles
const RADIANS-PER-MILE = 1 / EARTH-RADIUS # the angle subtended at earth's center per mile along circumference

$ \input .on \keypress, -> calculate! if it.key is \Enter
$ \#btnCalculate .on \click, calculate

function calculate
  h0 = get-val \h0
  d0 = get-val \d0
  d1 = get-horizon-distance h0

  $ \#d1 .text d1
  $ \#h1 .text get-target-hidden-height d0, d1

function get-horizon-distance h0
  r-vert = EARTH-RADIUS - ft-to-miles h0
  theta  = Math.acos r-vert / EARTH-RADIUS
  theta / RADIANS-PER-MILE

function get-target-hidden-height d0, d1
  return 0 if d0 < d1
  rads = (d1 - d0) * RADIANS-PER-MILE
  r-vert = EARTH-RADIUS * Math.cos rads
  (EARTH-RADIUS - r-vert) * FEET-PER-MILE

function ft-to-miles
  it / FEET-PER-MILE

function get-val
  parseFloat($ "##it" .val!)

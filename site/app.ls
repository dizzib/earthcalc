# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

const FEET-PER-MILE    = 5280ft
const EARTH-RADIUS     = 4000miles
const RADIANS-PER-MILE = 1 / EARTH-RADIUS # the angle subtended at earth's center per mile along circumference

$ \input .on \keypress, ->
  return unless it.key is \Enter
  calculate!

$ \#btnCalculate .on \click, calculate

function calculate
  height =
    eye: get-val \txtEyeHeight
  dist =
    target: get-val \txtTargetDist
    horiz : get-horizon-distance height.eye

  $ \#horizonDist        .text dist.horiz
  $ \#targetHiddenHeight .text get-target-hidden-height dist

function get-horizon-distance eye-height
  r-vert = EARTH-RADIUS - ft-to-miles eye-height
  theta  = Math.acos r-vert / EARTH-RADIUS
  theta / RADIANS-PER-MILE

function get-target-hidden-height dist
  dist.h2t = dist.target - dist.horiz
  rads = dist.h2t * RADIANS-PER-MILE
  r-vert = EARTH-RADIUS * Math.cos rads
  (EARTH-RADIUS - r-vert) * FEET-PER-MILE

function ft-to-miles
  it / FEET-PER-MILE

function get-val
  parseFloat($ "##it" .val!)

# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

const FEET-PER-METRE   = 3.2808
const MILES-PER-KM     = 0.621371192237
const EARTH-RADIUS     = 6371km
const RADIANS-PER-KM   = 1 / EARTH-RADIUS # the angle subtended at earth's center per km along circumference

# 'factor' is used to convert to/from metric units for the calculation
# 'switch' is used to flip between metric and imperial.
const UNITS =
  imperial:
    minor:
      name  : \feet
      factor: 1 / FEET-PER-METRE
      switch: FEET-PER-METRE
    major:
      name  : \miles
      factor: 1 / MILES-PER-KM
      switch: MILES-PER-KM
  metric:
    minor:
      name  : \metres
      factor: 1
      switch: 1 / FEET-PER-METRE
    major:
      name  : \km
      factor: 1
      switch: 1 / MILES-PER-KM

var units # currently selected units

initialise-units \imperial
calculate!

$ \input .on \keypress, -> calculate! if (it.key or it.keyIdentifier) is \Enter
$ \#btnCalculate .on \click, calculate
$ '#metric,#imperial' .on \click, -> switch-units it.toElement.value

## helpers

function calculate
  h0    = get-val \h0
  d0    = get-val \d0
  h0_m  = h0 * units.minor.factor
  d0_km = d0 * units.major.factor
  d1_km = get-horizon-distance_km h0_m
  h1_m  = get-target-hidden-height_m d0_km, d1_km
  d1    = d1_km / units.major.factor
  h1    = h1_m  / units.minor.factor

  $ \#d1 .text d1
  $ \#h1 .text h1

function get-horizon-distance_km h0_m
  r-vert = EARTH-RADIUS - h0_m * 0.001km_per_m
  theta  = Math.acos r-vert / EARTH-RADIUS
  theta / RADIANS-PER-KM

function get-target-hidden-height_m d0_km, d1_km
  return 0 if d0_km < d1_km
  rads = (d1_km - d0_km) * RADIANS-PER-KM
  r-vert = EARTH-RADIUS * Math.cos rads
  (EARTH-RADIUS - r-vert) * 1000m_per_km

function get-val
  parseFloat($ "##it" .val!)

function show-units
  $ '.unit-minor .unit' .text it.minor.name
  $ '.unit-major .unit' .text it.major.name

function initialise-units
  units := UNITS[it]
  $ "input##it" .prop \checked, true
  show-units units

function switch-units
  show-units units := UNITS[it]
  $ \#h0 .val (units.minor.switch * get-val \h0)
  $ \#d0 .val (units.major.switch * get-val \d0)
  calculate!

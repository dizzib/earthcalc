# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

const FEET-PER-METRE  = 3.2808
const MILES-PER-KM    = 0.621371192237
const EARTH-RADIUS-KM = 6371km

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

var unit-id # currently selected

initialise!
calculate!

$ \input .on \keypress -> calculate! if (it.key or it.keyIdentifier) is \Enter
$ \#btnCalculate .on \click calculate
$ '#metric,#imperial' .on \click -> switch-unit it.target.value

## helpers

function calculate
  h0    = get-val \h0
  d0    = get-val \d0
  unit  = UNITS[unit-id]
  h0_km = h0 * unit.minor.factor * 0.001km_per_m
  d0_km = d0 * unit.major.factor
  d1_km = get-horizon-distance_km h0_km
  h1_m  = get-target-hidden-height_km(d0_km - d1_km) * 1000m_per_km
  d1    = d1_km / unit.major.factor
  h1    = h1_m  / unit.minor.factor

  $ \#d1 .text d1.toFixed 6
  $ \#h1 .text h1.toFixed 4

  qs = queryString.stringify d0:d0, h0:h0, unit:unit-id
  history.replaceState void "" "?#qs"

function get-horizon-distance_km h0_km
  Math.sqrt(h0_km^2 + 2*EARTH-RADIUS-KM*h0_km)

function get-target-hidden-height_km d2_km
  return 0 if d2_km < 0
  Math.sqrt(d2_km^2 + EARTH-RADIUS-KM^2) - EARTH-RADIUS-KM

function get-val
  parseFloat($ "##it" .val!)

function initialise
  qs = queryString.parse location.search
  $ \#d0 .val(if (parseFloat d0 = qs.d0) then d0 else \30)
  $ \#h0 .val(if (parseFloat h0 = qs.h0) then h0 else \10)
  initialise-unit(if UNITS[u = qs.unit] then u else \imperial)

function initialise-unit
  $ "input##it" .prop \checked true
  show-unit unit-id := it

function show-unit
  $ '.unit-minor .unit' .text UNITS[it].minor.name
  $ '.unit-major .unit' .text UNITS[it].major.name

function switch-unit
  show-unit unit-id := it
  unit = UNITS[unit-id]
  $ \#h0 .val(unit.minor.switch * get-val \h0)
  $ \#d0 .val(unit.major.switch * get-val \d0)
  calculate!

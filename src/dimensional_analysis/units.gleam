import dimensional_analysis/dimension
import dimensional_analysis/unit
import tote/bag

// Creates a unit from a single dimension.
fn simple(dimension: dimension.Dimension) -> unit.Unit {
  unit.Unit(
    numerator: bag.new() |> bag.insert(1, dimension),
    denominator: bag.new(),
  )
}

pub fn second() {
  simple(dimension.Dimension(short: "s", singular: "second", plural: "seconds"))
}

pub fn hour() {
  simple(dimension.Dimension(short: "hr", singular: "hour", plural: "hours"))
}

pub fn meter() {
  simple(dimension.Dimension(short: "m", singular: "meter", plural: "meters"))
}

pub fn inch() {
  simple(dimension.Dimension(short: "in", singular: "inch", plural: "inches"))
}

pub fn foot() {
  simple(dimension.Dimension(short: "ft", singular: "foot", plural: "feet"))
}

pub fn mile() {
  simple(dimension.Dimension(short: "mi", singular: "mile", plural: "miles"))
}

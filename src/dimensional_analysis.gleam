import tote/bag

// For example, `miles`
pub type Dimension {
  Dimension(
    // The short representation for use in equations. Example: `s` for seconds
    short: String,
    // The singular representation for use in display. Example: `second` for seconds.
    singular: String,
    // The plural representation for use in display. Example: `seconds` for seconds.
    plural: String,
  )
}

// Creates a unit from a single dimension.
fn simple(dimension: Dimension) -> Unit {
  Unit(numerator: bag.new() |> bag.insert(1, dimension), denominator: bag.new())
}

pub fn second() {
  simple(Dimension(short: "s", singular: "second", plural: "seconds"))
}

pub fn hour() {
  simple(Dimension(short: "hr", singular: "hour", plural: "hours"))
}

pub fn meter() {
  simple(Dimension(short: "m", singular: "meter", plural: "meters"))
}

pub fn foot() {
  simple(Dimension(short: "ft", singular: "foot", plural: "feet"))
}

pub fn mile() {
  simple(Dimension(short: "mi", singular: "mile", plural: "miles"))
}

/// A unit is a fraction with a set of dimensions on top
/// and on bottom. These units can have different degrees.
/// Example: `m/s^2`.
/// A bag is the perfect data structure to describe this.
pub type Unit {
  Unit(numerator: bag.Bag(Dimension), denominator: bag.Bag(Dimension))
}

pub fn multiply(lhs: Unit, rhs: Unit) -> Unit {
  let numerator = bag.merge(lhs.numerator, rhs.numerator)
  let denominator = bag.merge(lhs.denominator, rhs.denominator)

  // Now we need to cancel units
  let simplified_numerator = numerator |> bag.subtract(denominator)
  let simplified_denominator = denominator |> bag.subtract(numerator)

  Unit(numerator: simplified_numerator, denominator: simplified_denominator)
}

pub fn divide(lhs: Unit, rhs: Unit) -> Unit {
  // Dividing a fraction simply means flipping the divisor and multiplying
  let rhs_mult = Unit(numerator: rhs.denominator, denominator: rhs.numerator)
  multiply(lhs, rhs_mult)
}

// An alias for divide to make units read nicely
pub const per = divide

import tote/bag

// For example, `miles`
pub type Dimension = String

/// A unit is a fraction with a set of dimensions on top
/// and on bottom. These units can have different degrees.
/// Example: `m/s^2`.
/// A bag is the perfect data structure to describe this.
pub type Unit {
  Unit(
    numerator: bag.Bag(Dimension),
    denominator: bag.Bag(Dimension)
  )
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


/// Creates a unit from a single dimension
pub fn simple(dimension: Dimension) -> Unit {
  Unit(numerator: bag.new() |> bag.insert(1, dimension), denominator: bag.new())
}
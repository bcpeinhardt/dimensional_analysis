import dimensional_analysis/dimension
import gleam/int
import gleam/list
import gleam/string
import tote/bag

/// A unit is a fraction with a set of dimensions on top
/// and on bottom. These units can have different degrees.
/// Example: `m/s^2`.
/// A bag is the perfect data structure to describe this.
pub type Unit {
  Unit(
    numerator: bag.Bag(dimension.Dimension),
    denominator: bag.Bag(dimension.Dimension),
  )
}

pub fn to_short_string(unit: Unit) -> String {
  let print_units = fn(bag) {
    let dims =
      bag
      |> bag.to_list

    case list.length(dims) {
      0 -> "1"
      _ ->
        dims
        |> list.map(fn(dim) {
          let #(dim, degree): #(dimension.Dimension, Int) = dim
          case degree {
            1 -> dim.short
            _ -> dim.short <> "^" <> int.to_string(degree)
          }
        })
        |> string.join(" * ")
    }
  }

  let frac =
    print_units(unit.numerator) <> " / " <> print_units(unit.denominator)
  case string.ends_with(frac, "/ 1") {
    False -> frac
    True -> frac |> string.drop_end(3)
  }
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

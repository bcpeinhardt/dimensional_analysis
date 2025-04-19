import dimensional_analysis/dimension
import dimensional_analysis/unit
import gleam/float
import tote/bag

pub opaque type Value(u) {
  Value(quantity: Float, unit: unit.Unit)
}

pub fn new_value(quantity: Float, unit: unit.Unit) -> Value(unit.Unit) {
  Value(quantity:, unit:)
}

pub fn to_string(value: Value(u)) -> String {
  let num = value.quantity |> float.to_string
  let unit_repr = value.unit |> unit.to_short_string
  num <> " " <> unit_repr
}

pub fn multiply(lhs: Value(a), rhs: Value(b)) -> Value(c) {
  let quantity = lhs.quantity *. rhs.quantity
  let unit = lhs.unit |> unit.multiply(rhs.unit)
  Value(quantity:, unit:)
}

// Converts a value to a different unit
pub fn convert(value: Value(a), conversion: #(Value(a), Value(b))) -> Value(b) {
  // This is like `convert(36 inches, #(12 inches, 1 ft)) => 3 ft`
  let q =
    value.quantity *. { conversion.1 }.quantity /. { conversion.0 }.quantity
  Value(quantity: q, unit: { conversion.1 }.unit)
}

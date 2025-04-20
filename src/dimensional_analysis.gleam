import dimensional_analysis/dimension
import dimensional_analysis/unit
import gleam/float
import tote/bag

pub opaque type Value {
  Value(quantity: Float, unit: unit.Unit)
}

pub fn new_value(quantity: Float, unit: unit.Unit) -> Value {
  Value(quantity:, unit:)
}

pub fn to_string(value: Value) -> String {
  let num = value.quantity |> float.to_string
  let unit_repr = value.unit |> unit.to_short_string
  num <> " " <> unit_repr
}

pub fn multiply(lhs: Value, rhs: Value) -> Value {
  let quantity = lhs.quantity *. rhs.quantity
  let unit = lhs.unit |> unit.multiply(rhs.unit)
  Value(quantity:, unit:)
}

// Converts a value to a different unit
pub fn convert(value: Value, conversion: #(Value, Value)) -> Value {
  // This is like `convert(36 inches, #(12 inches, 1 ft)) => 3 ft`
  let q =
    value.quantity *. { conversion.1 }.quantity /. { conversion.0 }.quantity
  let u =
    value.unit
    |> unit.multiply({ conversion.1 }.unit)
    |> unit.divide({ conversion.0 }.unit)
  Value(quantity: q, unit: u)
}

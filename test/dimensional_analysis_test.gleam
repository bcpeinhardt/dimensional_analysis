import gleeunit
import gleeunit/should

import dimensional_analysis as unit

pub fn main() {
  gleeunit.main()
}

pub fn basic_usage_test() {
  // A value with unit mile/hour multiplied by a value with unit hour 
  // should produce a value with the unit mile

  let speed = unit.simple("mile") |> unit.divide(unit.simple("hour"))
  let time = unit.simple("hour")
  unit.multiply(speed, time) |> should.equal(unit.simple("mile"))
}

pub fn degree_test() {
  let acceleration =
    unit.simple("meter")
    |> unit.divide(
      unit.simple("second") |> unit.multiply(unit.simple("second")),
    )
  let time = unit.simple("second")
  let speed = unit.simple("meter") |> unit.divide(unit.simple("second"))
  acceleration |> unit.multiply(time) |> should.equal(speed)
}

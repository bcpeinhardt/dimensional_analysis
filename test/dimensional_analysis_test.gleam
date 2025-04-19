import gleeunit
import gleeunit/should

import dimensional_analysis.{hour, meter, mile, multiply, per, second}

pub fn main() {
  gleeunit.main()
}

pub fn basic_usage_test() {
  // A value with unit mile/hour multiplied by a value with unit hour 
  // should produce a value with the unit mile

  let speed = mile() |> per(hour())

  let time = hour()

  multiply(speed, time) |> should.equal(mile())
}

pub fn degree_test() {
  let acceleration =
    meter()
    |> per(second())
    |> per(second())

  let time = second()

  let speed = meter() |> per(second())

  acceleration |> multiply(time) |> should.equal(speed)
}

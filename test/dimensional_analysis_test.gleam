import gleam/io
import gleeunit
import gleeunit/should

import dimensional_analysis.{convert, multiply, new_value, to_string}
import dimensional_analysis/unit.{per}
import dimensional_analysis/units.{foot, hour, inch, meter, mile, second}

pub fn main() {
  gleeunit.main()
}

pub fn basic_usage_test() {
  let width_rect = new_value(6.0, inch())
  let height_rect =
    new_value(2.0, foot())
    |> convert(#(new_value(1.0, foot()), new_value(12.0, inch())))
  let area = width_rect |> multiply(height_rect)
}

pub fn basic_dim_test() {
  // A value with unit mile/hour multiplied by a value with unit hour 
  // should produce a value with the unit mile

  let speed = mile() |> per(hour())

  let time = hour()

  unit.multiply(speed, time) |> should.equal(mile())
}

pub fn degree_test() {
  let acceleration =
    meter()
    |> per(second())
    |> per(second())

  let time = second()

  let speed = meter() |> per(second())

  acceleration |> unit.multiply(time) |> should.equal(speed)
}

pub fn conversion_test() {
  // 12 in / 1 ft
  // 36 in * (1 ft / 12 in) = 3 ft

  let length = new_value(36.0, inch())
  length
  |> convert(#(new_value(12.0, inch()), new_value(1.0, foot())))
  |> should.equal(new_value(3.0, foot()))
}

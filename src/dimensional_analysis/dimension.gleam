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

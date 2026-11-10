import {
  "./lib/arrays" as arrays
  "./lib/libc" as libc
  "./lib/strings" as strings
  "./lib/rational" as rational
  "./lib/ints" as ints
}

str HELP = """
Usage: fractran <file> <input>

Arguments:
  <file>      The Fractran file to execute.
  <input>     The input to the Fractran program.

Options:
  -h, --help  Show this help and exit.
"""

str[] args = @args()
str[] args = args[1:$]

if {
  "-h" in args or "--help" in args -> {
    @println(HELP)
    libc.exit(0)
  }
  args.len < 1 -> {
    @eprintln("""
      Missing required arguments: <file> <input>
      See fractran --help for more information.
      """)
    libc.exit(1)
  }
  args.len < 2 -> {
    @eprintln("""
      Missing required arguments: <input>
      See fractran --help for more information.
      """)
    libc.exit(1)
  }
  _ -> {}
}

str file = libc.read_to_str(args[0])

str input = args[1]
mut rational.Rational input = try rational.parse(input)

str[] lines = strings.lines(file)
rational.Rational[] lines = arrays.map<str, rational.Rational>(lines, fn(str s) rational.Rational {
  return rational.parse(s) catch err {
    @eprintln("Error parsing source file: {err}")
    libc.exit(1)
  }
})

while true {
  rational.Rational frac = arrays.find<rational.Rational>(lines, fn(rational.Rational r) bool {
    return rational.multiply(r, input).denominator == 1
  }) else { break }
  input = rational.multiply(input, frac)
  if {
    ints.is_power_of_two(input.numerator) -> { @println(libc.ilog2(input.numerator)) }
    _ -> {}
  }
}

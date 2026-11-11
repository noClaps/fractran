import {
  "./strings" as strings
  "./ints" as ints
}

pub struct Rational {
  int numerator
  int denominator
}

pub fn parse(str s) Rational! {
  str num, str den = strings.split_once(s, '/') else {
    return Rational{
      .numerator = ints.parse(s) catch err { throw "couldn't parse {s} as rational: {err}" },
      .denominator = 1,
    }
  }
  str num, str den = (strings.strip(num), strings.strip(den))
  return Rational{
    .numerator = ints.parse(num) catch err { throw "couldn't parse numerator: {err}" },
    .denominator = ints.parse(den) catch err { throw "couldn't parse denominator: {err}" },
  }
}

pub fn multiply(Rational lhs, int rhs) Rational {
  mut Rational r = lhs
  r.numerator = r.numerator * rhs
  return simplify(r)
}

pub fn simplify(Rational r) Rational {
  int gcd = ints.gcd(r.numerator, r.denominator)
  return Rational{.numerator = r.numerator / gcd, .denominator = r.denominator / gcd}
}

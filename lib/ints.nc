import { "./libc" as libc }

pub fn parse(str s) int! {
  mut int num = 0
  for i in s {
    if s[i] {
      ' ', '\n', '\t' -> { continue }
      _ -> {
        int digit = parse_char(s[i]) catch err { throw "couldn't parse {s} as int: {err}" }
        num = num * 10 + digit
      }
    }
  }
  return num
}
fn parse_char(char c) int! {
  if c {
    '0' -> { return 0 }
    '1' -> { return 1 }
    '2' -> { return 2 }
    '3' -> { return 3 }
    '4' -> { return 4 }
    '5' -> { return 5 }
    '6' -> { return 6 }
    '7' -> { return 7 }
    '8' -> { return 8 }
    '9' -> { return 9 }
    _ -> { throw "invalid digit: {c}" }
  }
}

pub fn gcd(int a, int b) int {
  if b {
    0 -> { return a }
    _ -> { return gcd(b, a % b) }
  }
}

pub fn is_power_of_two(int n) bool {
  return 2 ** libc.ilog2(n) == n
}

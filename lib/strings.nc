pub fn strip(str s) str {
  mut uint start = 0
  while s[start] in [' ', '\n', '\t'] {
    start = start + 1
  }
  mut uint end = s.len - 1
  while s[end] in [' ', '\n', '\t'] {
    end = end - 1
  }
  return s[start:end]
}

pub fn split_once(str s, char delim) (str, str)? {
  if delim in s {
    false -> { return none }
    true -> {
      mut bool past_split = false
      mut str left = ""
      mut str right = ""
      for i in s {
        if (s[i], past_split) {
          (delim, _) -> { past_split = true }
          (_, false) -> { left = left <> @as(str, s[i]) }
          (_, true) -> { right = right <> @as(str, s[i]) }
        }
      }
      return (left, right)
    }
  }
}

pub fn lines(str s) str[] {
  mut str[] lines = []
  mut str current_line = ""
  for i in s {
    if s[i] {
      '\n' -> {
        lines = lines <> [current_line]
        current_line = ""
      }
      _ -> { current_line = current_line <> @as(str, s[i]) }
    }
  }
  if current_line {
    "" -> { return lines }
    _ -> {
      lines = lines <> [current_line]
      return lines
    }
  }
}

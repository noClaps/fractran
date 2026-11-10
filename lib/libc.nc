extern "./libc.c" as libc {
  fn c_exit(int code) never = "c_exit"
  fn c_read(str path) str = "c_read"
  fn c_ilog2(int n) int = "c_ilog2"
}

pub fn exit(int code) never {
  libc.c_exit(code)
}

pub fn read_to_str(str path) str {
  return libc.c_read(path)
}

pub fn ilog2(int n) int {
  return libc.c_ilog2(n)
}

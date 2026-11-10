pub fn map<type I, type O>(I[] arr, (fn(I) O) f) O[] {
  mut O[] out = []
  for i in arr {
    out = out <> [f(arr[i])]
  }
  return out
}

pub fn find<type T>(T[] arr, (fn(T) bool) f) T? {
  for i in arr {
    if f(arr[i]) {
      true -> { return arr[i] }
      false -> {}
    }
  }
  return none
}

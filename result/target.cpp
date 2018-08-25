def test_func :
  int a, int b => int {
  return a + b;
}

def main :
   => int {
  int local_var1 := 0;
  int local_var2 := 0;
  test_func(local_var1, local_var2);
  return 0;
}

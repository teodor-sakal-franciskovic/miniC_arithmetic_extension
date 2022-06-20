//RETURN: 11

int main(){
  int a;
  int b;
  int d;
  lambda x = int a, int b: a + b;
  a = 3;
  lambda x = int a : a + 1;
  a = 5;
  b = 3;
  d = lambda x(a);
  b = d + lambda x(b, 2);
  return b;
}

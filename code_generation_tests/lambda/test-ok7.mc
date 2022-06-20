//RETURN: 54

int main(){
  int a;
  int b;
  int c;
  lambda x = int a, int b: a + b;
  lambda y = int a: a * 2;
  a = 5;
  b = 3;
  c = (lambda x(a - 1, b - 1) + lambda y(a * b - 1) + lambda x(10, 10));
  return (lambda y(c) + lambda y(c)) / lambda y(2);
}

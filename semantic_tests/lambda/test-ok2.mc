//2 razlicite lambda funkcije

int main(){
  int a;
  int b;
  int c;
  int d;
  int e;
  int f;
  lambda x = int b, int c, int g : c + b + g;
  e = lambda x(1, 1, 1);
  a = lambda x(b, 3, c);
  lambda y = int a, int d: a * 2 + d;
  e = lambda y(c, e);
  e = lambda y(f, a);
  return 2;
}


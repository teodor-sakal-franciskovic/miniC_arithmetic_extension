//jedna lambda funkcija sa vise parametara

int main(){
  int a;
  int b;
  lambda x = int a, int b, int c : a * b * c;
  a = lambda x(1, 1, 1);
  b = lambda x(a, a, a);
  a = lambda x(1, 2, b);
  return 2;
}


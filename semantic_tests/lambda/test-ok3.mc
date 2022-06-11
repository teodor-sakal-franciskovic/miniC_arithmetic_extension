//jedna lambda funkcija sa vise parametara

int main(){
  int a;
  int b;
  a = 2;
  lambda x = int a, int b, int c : a * b * c;
  lambda x = int a, int b : a + b;
  
  b = lambda x(1, 2, 3);
  b = lambda x(1, a);
  return 2;
}

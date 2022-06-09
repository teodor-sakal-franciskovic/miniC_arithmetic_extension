//RETURN: 7

int main(){
  int a;
  int b;
  int c;
  lambda x = int b, int a : a * b + 1;
  b = 2;
  c = 3;
  a = lambda x(3, b);
  return a;
}


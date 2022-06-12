//RETURN: 4

int main(){
  int a;
  int b;
  lambda x = int a, int b: a + b;
  a = 5;
  b = 3;
  return lambda x(5, 3) / 2;
}

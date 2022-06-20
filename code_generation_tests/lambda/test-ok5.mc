//RETURN: 31
int foo(int a){
   int b;
   b = a + 2;
   return b;
}

int main(){
   int d;
   int e;
   int f;
   int g;
   
   lambda x = int a, int b: a + b;
   d = 5;
   e = 3;
   f = lambda x(d + e, d * e) + lambda x(d - e + 1, d - e - 1);
   g = lambda x(d - e, d - e);
   return f + g;
}

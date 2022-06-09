//RETURN: 20
int foo(int a){
   int b;
   b = a + 2;
   return b;
}

int main(){
   int d;
   int e;
   int f;
   
   lambda x = int a, int b, int c : a * b + b + c;
   d = 10;
   e = 1;
   f = lambda x(d, e, 3);
   return f;
}

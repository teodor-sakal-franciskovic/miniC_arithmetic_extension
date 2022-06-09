//RETURN: 43
int foo(int a){
   int b;
   b = a + 2;
   return b;
}

int main(){
   int d;
   int e;
   int f;
   
   lambda x = int a, int b, int c : a * b + a + c; //43
   d = 10;
   e = 1;
   f = lambda x(5, 7, 3);
   return f;
}

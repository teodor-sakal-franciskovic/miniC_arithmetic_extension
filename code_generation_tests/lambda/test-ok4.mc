//RETURN: 39

int foo(int a){
   int b;
   b = a + 2;
   return b;
}

int main(){
   int a;
   int b;
   
   lambda x = int a, int b : (3 + a + b) * (a - 2); //13 * 3
   a = 3;
   b = lambda x(foo(a), 5); //39
   return b;
}

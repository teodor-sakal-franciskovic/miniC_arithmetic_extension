//RETURN: 21

int main(){
   int a;
   int b;
   int c;
   int d;
   
   lambda x = int b, int a : a * b;
   a = lambda x(2, 3); //6
   lambda y = int c, int d : c + d;
   c = 5;
   d = 5;
   b = lambda y(c + d, d); //15
   a = a + b;
   return a;
}

//Sve operacije

int foo(int d){
	return d * 2;
}

unsigned foofoo(unsigned du){
	return du + 5u;
}

int main() {
	int a;
	int b;
	int c;
	int d;
	unsigned e;
	unsigned f;
	unsigned g;
	
	a = b * c;
	b = (a / c) + foo(a);
	c = a * (a - b);
	d = (a / (b + c)) - foo(b);
	
	e = f * g - f;
	f = (g + e) / foofoo(g);
	g = (e * (e - f)) / foofoo(g);
	
	return 2;

}

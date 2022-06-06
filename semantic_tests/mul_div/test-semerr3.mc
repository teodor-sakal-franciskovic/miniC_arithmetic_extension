//Svi operandi - razliciti tipovi

int foo(int d){
	return d + 2;
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
	
	a = b * e;
	b = (a / e) - foofoo(g);
	c = a * (a + f);
	d = (e - (b + c)) / foo(b);
	
	e = a + g / f;
	f = (g + e) / foofoo(g);
	g = (e * (e + b)) - foo(a);
	
	return 2;

}

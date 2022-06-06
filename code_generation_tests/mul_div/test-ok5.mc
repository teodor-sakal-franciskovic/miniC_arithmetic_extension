//RETURN: 5

int foo(int a){
	int x;
	x = a + 3 * 2;
	return x;
}


int main()
{
	int x;
	int y;
	int z;
	x = 5 * 3 - 8 / 2 - 1; //10
	y = x + foo(x) * 2; // 42
	z = (y - 2) / (3 + 5); // 5
	return z;
}

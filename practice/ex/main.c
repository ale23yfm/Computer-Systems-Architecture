#include <stdio.h>

int suma(int, int);
int product(int, int);

int main()
{
    int a = 0;
    int b = 0;
    int sum = 0;
    int prod = 0;
    
    printf("a=");
    scanf("%d", &a);
    
    printf("b=");
    scanf("%d", &b);
    
    sum = suma(a,b);
    prod = product(a,b);
    
    printf("Suma numerelor este %d", sum);
    printf("Produsul numerelor este %d", prod);
    
    return 0;
}

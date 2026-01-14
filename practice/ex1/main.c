#include <stdio.h>

void read_numbers(char* );

int main()
{
    char text[100];
        
    printf("Enter the numbers: ");
    scanf("%[^\n]", text);
    
    read_numbers(text);
        
    return 0;
}

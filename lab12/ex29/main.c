#include <stdio.h>

void sentence(char* );

int main()
{
    char text[100];
        
    printf("Enter the text: ");
    fgets(text, sizeof(text), stdin);
    
    sentence(text);

    return 0;
}

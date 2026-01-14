#include <stdio.h>

void display_last_char_count(char* );
int sum_digits(char* );


int main()
{
    char text[21];
        
    printf("Enter the text: ");
    scanf("%s", text);
    
    display_last_char_count(text);
    
    int sum = sum_digits(text);
    printf("Sum of digits is %d\n", sum);

    return 0;
}

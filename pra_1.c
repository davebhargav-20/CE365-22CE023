#include <stdio.h>
#include <string.h>
#include <stdbool.h>


bool isValidString(const char* str) {
    int i = 0;


    while (str[i] == 'a') {
        i++;
    }


    if (str[i] == 'b' && str[i + 1] == 'b' && str[i + 2] == '\0') {
        return true;
    }

    return false;
}

int main() {
    char input[100];

    printf("Enter your string: ");

    scanf("%99s", input);


    if (isValidString(input)) {
        printf("Valid String\n");
    } else {
        printf("Invalid String\n");
    }

    return 0;
}

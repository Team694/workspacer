#include <stdio.h>

int main(int argc, char* argv[]) {
    char* uname = argv[1];
    char* pass = argv[2];
    int success = validateLogin(uname, pass);
    if (!success) {
        printf("invalid\n");
    }
    return 0;
}
#include <stdio.h>

int main(int argc, char* argv[]) {
    char* uname = argv[1];
    normalize_uname(uname);

    if (argc == 0) {
        return 1;
    }
    if (!userExists(argv[1])) {
        printf("available\n");
    } else {
        printf("taken\n");
    }
    return 0;
}

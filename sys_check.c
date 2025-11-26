#include <stdio.h>
#include <stdlib.h>
#include <sys/utsname.h>

int main() {
    struct utsname buffer;

    if (uname(&buffer) != 0) {
        perror("uname");
        exit(EXIT_FAILURE);
    }

    printf("OS Node: %s\n", buffer.nodename);
    printf("OS Name: %s\n", buffer.sysname);
    printf("Release: %s\n", buffer.release);
    
    // Check if we are actually on Linux
    return 0;
}

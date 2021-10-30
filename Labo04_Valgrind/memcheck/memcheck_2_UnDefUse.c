/* Laboratoire de SeS numero 4 - Valgrind
 * Quentin Müller et Tristan Traiber
 * 30.10.2021
 * 
 * Test de memcheck
 * 
 * 
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

    // Non-initialized variable
    int noInit;

    printf("Trying to use a non-initialized value : \n");
    printf("Non-initialized value : %d\n", noInit);

    printf("\n----------------\n");
    return 0;
}
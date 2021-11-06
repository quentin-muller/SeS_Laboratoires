/* Laboratoire de SeS numero 4 - Valgrind
 * Quentin Müller et Tristan Traiber
 * 30.10.2021 
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

    int noInit;

    printf("Essai d'utilisation d'une variable non init : \n");
    printf("Valeur de la variable : %d\n", noInit);
    printf("\n********************************************\n");
    return 0;
}
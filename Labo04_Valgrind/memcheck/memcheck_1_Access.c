/* Laboratoire de SeS numero 4 - Valgrind
 * Quentin Müller et Tristan Traiber
 * 30.10.2021
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int * Stack0(){
  int varStack0 = 8;
  return &varStack0;
}
int main() {

    // Getting address to memory from another stack
    int * pStack0 = Stack0();

    printf("Essai d'acces memoire depuis une autre pile : \n");
    printf("Valeur attendue : 8 / lue : %d\n",* pStack0);
    printf("\n********************************************\n");
    return 0;
}

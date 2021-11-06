/* Laboratoire de SeS numero 4 - Valgrind
 * Quentin Müller et Tristan Traiber
 * 30.10.2021
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int * otherStack();
int main() {

    // Getting address to memory from another stack
    int * pMemOtherStack = otherStack();

    printf("Essai d'acces memoire depuis une autre pile : \n");
    printf("Valeur attendue\t: 4\n");
    printf("Valeur lue \t: %d\n", * pMemOtherStack);
    printf("\n********************************************\n");
    return 0;
}

int * otherStack(){
  static int unattainableMem = 4;
  return &unattainableMem;
}

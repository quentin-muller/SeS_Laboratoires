/* Laboratoire de SeS numero 4 - Valgrind
 * Quentin Müller et Tristan Traiber
 * 30.10.2021
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NB_ALLOC = 20;
int main() {
    int * pMem = (int*) malloc(sizeof(int));

    printf("Essai de l'allocation dynamique sans liberation");
    printf("Allocation dynamique sans liberation, %d fois\n", NB_ALLOC);
    if(pMem != NULL){
      for (int i = 0; i < NB_ALLOC; i++) {
        pMem = (int*) malloc(sizeof(int));
      }
    }
    else{
      printf("pMem pas init\n");
    }
    printf("\n********************************************\n");

    return 0;
}
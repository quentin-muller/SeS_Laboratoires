/* Laboratoire de SeS numero 4 - Valgrind
 * Quentin Müller et Tristan Traiber
 * 30.10.2021
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    int * pMem = (int*) malloc(sizeof(int));

    printf("Essai de la double lberation de la memoire\n");
    if(pMem != NULL){
      free((void*)pMem);
      free((void*)pMem);
    }
    else{
      printf("Pas de memoire a liberer !\n");
    }
    printf("\n********************************************\n");

    return 0;
}
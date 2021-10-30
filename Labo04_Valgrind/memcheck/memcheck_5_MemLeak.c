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
    const int intNumber = 20;
    // Memory leak
    int * pMem = (int*) malloc(sizeof(int));


    printf("Malloc without freeing, %d times\n",intNumber);
    if(pMem != NULL){
      for (int i = 0; i < intNumber; i++) {
        pMem = (int*) malloc(sizeof(int));
      }

    }else{
      printf("Base memory not initialized !\n");
    }


    printf("\n----------------\n");

    return 0;
}
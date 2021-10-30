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

    // Double freeing memory
    int * pMemory = (int*) malloc(sizeof(int));

    printf("Double freeing memory\n");
    if(pMemory != NULL){
      free((void*)pMemory);
      free((void*)pMemory);
    }else{
      printf("No memory was freed !\n");
    }

    printf("\n----------------\n");

    return 0;
}
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

    // using memcpy on overlapping pointers
    // pointer to an int with 2 free bytes after
    int * pDest = (int*) malloc(sizeof(int)+2);
    int * pSource = (int*) ((char*) pDest + 2);

    *pSource = 4;

    printf("Copying data from source to destination (2-byte overlap)\n");
    if(pSource != NULL){
      printf("Source pointer data : expected = 4, actual = %d\n",*pSource);
      printf("Dest pointer data : expected = 262144, actual = %d\n",*pDest);
      memcpy(pDest,pSource,sizeof(int));
      printf("Source pointer data : expected = 4, actual = %d\n",*pSource);
      printf("Dest pointer data : expected = 262144, actual = %d\n",*pDest);
    }else{
      printf("Source not initialized !\n");
    }
    printf("\n----------------\n");



    return 0;
}
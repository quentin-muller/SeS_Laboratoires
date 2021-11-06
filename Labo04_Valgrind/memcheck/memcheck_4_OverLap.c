/* Laboratoire de SeS numero 4 - Valgrind
 * Quentin Müller et Tristan Traiber
 * 30.10.2021
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

    int * pTO = (int*) malloc(sizeof(int)+2);
    int * pFROM = (int*) ((char*) pTO + 2);

    *pFROM = 6;
    printf("Essai de copie avec memcpy de trop grande valeur");
    printf("Copie des data depuis pFROM a pTO avec 2 bytes supplementaire\n");
    if(pFROM != NULL){
      printf("pFROM data / attendue = 6      / lue = %d\n",*pFROM);
      printf("pTO data   / attendue = 393216 / lue = %d\n",*pTO);

      memcpy(pTO,pFROM,sizeof(int));
      printf("pFROM data / attendue = 6      / lue = %d\n",*pFROM);
      printf("pTO data   / attendue = 6      / lue = %d\n",*pTO);
    }
    else{
      printf("pFROM pas init !\n");
    }
    printf("\n********************************************\n");
    return 0;
}
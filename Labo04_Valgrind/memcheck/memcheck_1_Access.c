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

int * otherStack();
int main() {

    // Getting address to memory from another stack
    int * pMemOtherStack = otherStack();

    printf("Trying to reach memory from another stack : \n");
    printf("Expected value : 4\n");
    printf("Read value: %d\n", * pMemOtherStack);

    printf("\n----------------\n");
    return 0;
}


int * otherStack(){
  static int unattainableMem = 4;
  return &unattainableMem;
}
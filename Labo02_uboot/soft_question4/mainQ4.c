/*
Laboratoire de SeS 2 sur u-boot
Quentin Müller et Tristan Traiber
30.10.2021
*/

#include <stdio.h>

#define SIZE_TAB 10
#define SIZE_OVERFLOW 30
#define SIZE_UNDERFLOW 30

int main() {

    printf("SeS - Labo u-boot 'Quentin Müller et Tristan Traiber'\n\n");

    char tab[SIZE_TAB] = {0};
    
    printf("Le tableau va se remplir de 0 à N-1 puis deborder sur la stack de %d octets ", SIZE_OVERFLOW);

    printf("Début du programme\n[");

    for (char i = 0;i<SIZE_TAB + SIZE_OVERFLOW ;i++) {
        tab[i] = i;
        //printf("%d, ",tab[i]);
    }

    printf("]\n Fin de l'écriture plus overflow\n[");

    for (char i = 0;i<SIZE_UNDERFLOW;i++) {
        tab[-i] = i;
        //printf("%d, ",tab[-i]);
    }
    printf("]\n Fin de l'écriture plus overflow\n");

    printf("Fin du programme");
    return 0;
}
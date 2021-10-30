/* Laboratoire de SeS numero 4 - Valgrind
 * Quentin Müller et Tristan Traiber
 * 30.10.2021
 * 
 * 
 * Test de cachegrind
 *
 * Un tableau de NxN est rempli de valeurs dans le "bon" et le "mauvais" sens.
 * C'est à dire un remplissage "linéaire" et un remplissage avec des sauts d'adresses
 * Afin de montrer la sur-utilisation de la cache dans l'appel du tableau
 * 
*/
#include <iostream>
using namespace std;

#define N 1000

unsigned char tableau[N][N];

int main()
{
    cout << "Laboratoire 4 de Ses sur cachegrind" << endl;
    cout << "Programme mauvais :(" << endl;
    cout << "Remplir le tableau de manière sacadée" << endl;
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            tableau[j][i] = 1; //i <-> j
        }
    }
    cout << "FIN" << endl;
    return 0;
}
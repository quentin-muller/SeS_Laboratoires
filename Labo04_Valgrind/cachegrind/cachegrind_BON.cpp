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
    cout << "Laboratoire 4 de SeS sur cachegrind" << endl;
    cout << "Programme bon :)" << endl;
    cout << "Remplir le tableau de manière continues" << endl;
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            tableau[i][j] = 1;
        }
    }
    cout << "FIN" << endl;
    return 0;
}

/* stack

-- t[1][0]
-- t[0][N-1]

-- t[0][1]
-- t[0][0]
*/
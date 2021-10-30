/* Laboratoire de SeS numero 4 - Valgrind
 * Quentin Müller et Tristan Traiber
 * 30.10.2021
 * 
 * 
 * Test de massif
 * 
 * 
*/


#include <iostream>
#include <unistd.h>

using namespace std;

#define N 10000
#define N_TAB 10
#define TIME_SLEEP 100000

unsigned char *tableau[N_TAB];
unsigned int i = 0;

void allocation(unsigned int i)
{
    cout << "Allocation de " << N << " octets" << endl;
    tableau[i] = (unsigned char *)malloc(N);
}

void liberation(unsigned int i)
{
    cout << "Liberation de " << N << " octets" << endl;
    if (tableau[i])
        free((void *)tableau[i]);
    tableau[i] = NULL;
}

int main()
{
    cout << "Laboratoire 4 de Ses sur cachegrind" << endl;
    cout << "Programme mauvais :(" << endl;
    // on alloue tout le tableau
    for (int i = 0; i < N_tableau; i++)
    {
        usleep(100000);
        allocation(i);
    }
    cout << "Tout alloue" << endl;
    //on le libère pas
    liberation(0);
    cout << "FIN sans libération" << endl;
    return 0;
}
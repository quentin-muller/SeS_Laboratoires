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

#define N          10000
#define N_TAB      10
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
    cout << "Laboratoire 4 de SeS sur massif" << endl;
    cout << "Programme bon :)" << endl;
    // on alloue tout le tableau
    for (int i = 0; i < N_TAB; i++)
    {
        usleep(TIME_SLEEP);
        allocation(i);
    }
    cout << "Tout alloue" << endl;
    //on libère tout le tableau
    for (int i = 0; i < N_TAB; i++)
    {
        usleep(TIME_SLEEP);
        liberation(i);
    }
    cout << "FIN avec libération" << endl;
    return 0;
}
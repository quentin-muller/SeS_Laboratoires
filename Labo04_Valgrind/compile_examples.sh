# Compilation de cachegrind
g++ -Wall -Wextra cachegrind/cachegrind_BON.cpp -o cachegrind/cachegrind_bon
g++ -Wall -Wextra cachegrind/cachegrind_PASBON.cpp -o cachegrind/cachegrind_pasbon

# Compilation de memcheck
gcc -Wall -Wextra memcheck/memcheck_1_Access.c -o memcheck/memcheck_acces
gcc -Wall -Wextra memcheck/memcheck_2_UnDefUse.c -o memcheck/memcheck_undefuse
gcc -Wall -Wextra memcheck/memcheck_3_IncFree.c -o memcheck/memcheck_incfree
gcc -Wall -Wextra memcheck/memcheck_4_OverLap.c -o memcheck/memcheck_ovrlp
gcc -Wall -Wextra memcheck/memcheck_5_MemLeak.c -o memcheck/memcheck_memleak

# Compilation de massif
g++ -Wall -Wextra massif/massif_BON.cpp -o massif/massif_bon
g++ -Wall -Wextra massif/massif_PASBON.cpp -o massif/massif_pasbon


# bitmap
g++ -Wall -Wextra bitmap/bitmap.c -o bitmap/bitmap
g++ -Wall -Wextra bitmap/bitmap_corr.c -o bitmap/bitmap_corr
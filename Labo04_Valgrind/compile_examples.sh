# Compilation de cachegrind
g++ -Wall -Wextra cachegrind/cachegrind_BON.cpp -o cachegrind/cachegrind_bon
g++ -Wall -Wextra cachegrind/cachegrind_PASBON.cpp -o cachegrind/cachegrind_pasbon

# Compilation de memcheck
gcc -Wall -Wextra memcheck/main_memcheck.c -DMODE=0 -o memcheck/memcheck_notalloc
gcc -Wall -Wextra memcheck/main_memcheck.c -DMODE=1 -o memcheck/memcheck_notinit
gcc -Wall -Wextra memcheck/main_memcheck.c -DMODE=2 -o memcheck/memcheck_free
gcc -Wall -Wextra memcheck/main_memcheck.c -DMODE=3 -o memcheck/memcheck_cpy
gcc -Wall -Wextra memcheck/main_memcheck.c -DMODE=4 -o memcheck/memcheck_leak

# Compilation de massif
g++ -Wall -Wextra massif/massif_BON.cpp -o massif/massif_bon
g++ -Wall -Wextra massif/massif_PASBON.cpp -o massif/massif_pasbon


# bitmap
#g++ -Wall -Wextra bitmap/bitmap.c -o bitmap/bitmap
#g++ -Wall -Wextra bitmap/bitmap_repair.c -o bitmap/bitmap_repair
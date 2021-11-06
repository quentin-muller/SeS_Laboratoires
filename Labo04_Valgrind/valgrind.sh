# Lancement de cachegrind
cd cachegrind
valgrind --log-file="cachegrind_BON_log.txt" --tool=cachegrind --cachegrind-out-file="out_BON.txt" ./cachegrind_BON
valgrind --log-file="cachegrind_PASBON_log.txt" --tool=cachegrind --cachegrind-out-file="out_PASBON.txt" ./cachegrind_PASBON
cd ..

# Lancement de memcheck
cd memcheck
valgrind --log-file="memcheck_acces_log.txt" --tool=memcheck ./memcheck_acces
valgrind --log-file="memcheck_undefuse_log.txt" --tool=memcheck ./memcheck_undefuse
valgrind --log-file="memcheck_incfree_log.txt" --tool=memcheck ./memcheck_incfree
valgrind --log-file="memcheck_ovrlap_log.txt" --tool=memcheck ./memcheck_ovrlp
valgrind --log-file="memcheck_memleak_log.txt" --tool=memcheck ./memcheck_memleak
cd ..


# Lancement de massif
cd massif
valgrind --log-file="massif_BON.txt" --tool=massif --time-unit=B --massif-out-file="out_BON.out.pid" ./massif_BON
valgrind --log-file="massif_PASBON.txt" --tool=massif --time-unit=B --massif-out-file="out_PASBON.out.pid" ./massif_PASBON
ms_print out_BON.out.pid > out_BON.txt
ms_print out_PASBON.out.pid > out_PASBON.txt
cd ..



# bitmap
cd bitmap
# Test wrong file
valgrind --log-file="massif.txt" --tool=massif --time-unit=B --massif-out-file="massif.out.pid" ./bitmap
valgrind --log-file="cachegrind.txt" --tool=cachegrind --cachegrind-out-file="cachegrind.txt" ./bitmap 
valgrind --log-file="callgrind.txt" --tool=callgrind --callgrind-out-file="callgrind.txt" ./bitmap
valgrind --log-file="memcheck.txt" --tool=memcheck ./bitmap
ms_print massif.out.pid > massif.txt

# Test repaired file
valgrind --log-file="bitmap_corr.txt" --tool=massif --time-unit=B --massif-out-file="massif_corr.out.pid" ./bitmap_corr
#valgrind --log-file="cachegrind_corr.txt" --tool=cachegrind --cachegrind-out-file="cachegrind_corr.txt" ./bitmap_corr
#valgrind --log-file="callgrind_corr.txt" --tool=callgrind --callgrind-out-file="callgrind_corr.txt" ./bitmap_corr
valgrind --log-file="memcheck_corr.txt" --tool=memcheck ./bitmap_corr
ms_print massif_corr.out.pid > massif_corr.txt
cd ..

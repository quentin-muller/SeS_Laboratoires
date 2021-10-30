# Lancement de cachegrind
cd cachegrind
valgrind --log-file="cachegrind_BON_log.txt" --tool=cachegrind --cachegrind-out-file="out_BON.txt" ./cachegrind_BON
valgrind --log-file="cachegrind_PASBON_log.txt" --tool=cachegrind --cachegrind-out-file="out_PASBON.txt" ./cachegrind_PASBON
cd ..

# Lancement de memcheck
cd memcheck
valgrind --log-file="memcheck_notalloc_log.txt" --tool=memcheck ./memcheck_notalloc
valgrind --log-file="memcheck_notinit_log.txt" --tool=memcheck ./memcheck_notinit
valgrind --log-file="memcheck_free_log.txt" --tool=memcheck ./memcheck_free
valgrind --log-file="memcheck_cpy_log.txt" --tool=memcheck ./memcheck_cpy
valgrind --log-file="memcheck_leak_log.txt" --tool=memcheck ./memcheck_leak
cd ..


# Lancement de massif
cd massif
valgrind --log-file="massif_BON.txt" --tool=massif --time-unit=B --massif-out-file="out_BON.out.pid" ./massif_BON
valgrind --log-file="massif_PASBON.txt" --tool=massif --time-unit=B --massif-out-file="out_PASBON.out.pid" ./massif_PASBON
ms_print out_BON.out.pid > out_BON.txt
ms_print out_PASBON.out.pid > out_PASBON.txt
cd ..



## bitmap
#cd bitmap
## Test wrong file
#valgrind --log-file="massif.txt" --tool=massif --time-unit=B --massif-out-file="massif.out.pid" ./bitmap
#valgrind --log-file="cachegrind.txt" --tool=cachegrind --cachegrind-out-file="cachegrind.txt" ./bitmap 
#valgrind --log-file="callgrind.txt" --tool=callgrind --callgrind-out-file="callgrind.txt" ./bitmap
#valgrind --log-file="memcheck.txt" --tool=memcheck ./bitmap
#ms_print massif.out.pid > massif.txt
## Test repaired file
#valgrind --log-file="bitmap_repair.txt" --tool=massif --time-unit=B --massif-out-file="massif_repair.out.pid" ./bitmap_repair
#valgrind --log-file="cachegrind_repair.txt" --tool=cachegrind --cachegrind-out-file="cachegrind_repair.txt" ./bitmap_repair
#valgrind --log-file="callgrind_repair.txt" --tool=callgrind --callgrind-out-file="callgrind_repair.txt" ./bitmap_repair
#valgrind --log-file="memcheck_repair.txt" --tool=memcheck ./bitmap_repair
#ms_print massif_repair.out.pid > massif_repair.txt
#cd ..

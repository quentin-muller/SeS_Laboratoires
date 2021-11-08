#./configure --prefix=/home/lmi/SeS/Labo05_ssh/intel

#make install

./configure --prefix=/home/lmi/SeS/Labo05_ssh/nanopi --host=aarch64-none-linux-gnu

make

sed -i 's/STRIP_OPT=-s/STRIP_OPT=-s --strip-program=aarch64-none-linux-gnu-strip/g' openssh-8.8p1/Makefile


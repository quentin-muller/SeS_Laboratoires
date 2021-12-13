#./configure --prefix=/home/lmi/SeS/Labo05_ssh/intel

#make install

echo "---- Begin ----"
#rm -rf nanopi/*

cd openssh-8.8p1

echo "-- Configure --"
./configure --prefix=/home/lmi/SeS/Labo05_ssh/nanopi --host=aarch64-none-linux-gnu --sysconfdir=/root/sshd

echo "---- Strip ----"
sed -i 's/STRIP_OPT=-s/STRIP_OPT=-s --strip-program=aarch64-none-linux-gnu-strip/g' Makefile

echo "---- makeI----"
make install

echo "---- Done ----"

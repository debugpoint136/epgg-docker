#!/bin/bash
cd /tmp
wget http://curl.haxx.se/download/curl-7.46.0.tar.bz2
tar -xvjf curl-7.46.0.tar.bz2
cd curl-7.46.0
make
make install

cd /home
cp /home/epigenomegateway /etc/apache2/sites-available
cd /etc/apache2/sites-enabled
ln -s ../sites-available/epigenomegateway .

service apache2 restart
service mysql start


cd /home
git clone https://github.com/debugpoint136/eg
cd eg
cd cgi-bin/jsmn-example
make
cd ../jsmn
make
cd ..
make
cp subtleKnife postdeposit /usr/lib/cgi-bin/
cp ucsc2jsonhub.py /usr/lib/cgi-bin/
mkdir /srv/epgg
chown www-data /srv/epgg
mkdir /srv/epgg/data
cd /srv/epgg/data
mkdir data
cd data/
mkdir subtleKnife
cd subtleKnife
mkdir seq
mkdir /srv/epgg/data/data/subtleKnife/hg19
mkdir /srv/epgg/data/data/subtleKnife/hg19/config
mkdir /srv/epgg/data/data/subtleKnife/hg19/session

mkdir /srv/epgg/data/data/subtleKnife/danRer10
mkdir /srv/epgg/data/data/subtleKnife/danRer10/config
mkdir /srv/epgg/data/data/subtleKnife/danRer10/session

chown www-data.www-data /srv/epgg/data/data/subtleKnife/hg19/session
chown www-data.www-data /srv/epgg/data/data/subtleKnife/danRer10/session

mkdir -p /var/www/html/browser/t
mkdir /srv/epgg/data/trash
chown www-data.www-data /var/www/html/browser/t /srv/epgg/data/trash
ln -s /srv/epgg/data/trash /usr/lib/
cd /home/eg/browser
mv css/ index.html js/ images/ /var/www/html/browser/
cd /home/eg/config

mysql -u "root" -Bse "CREATE DATABASE hg19;
CREATE DATABASE danRer10;
CREATE USER 'hguser'@'localhost' IDENTIFIED BY 'hguser';
GRANT ALL ON *.* TO 'hguser'@'localhost' IDENTIFIED BY 'hguser' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

mysql -h "localhost" -u "hguser" -p"hguser" "hg19" < "sessionUtils.sql"
mysql -h "localhost" -u "hguser" -p"hguser" "danRer10" < "sessionUtils.sql"

cp treeoflife /srv/epgg/data/data/subtleKnife/
cp hg19/tracks.json /srv/epgg/data/data/subtleKnife/hg19/config
cp hg19/publichub.json /srv/epgg/data/data/subtleKnife/hg19/config

cp danRer10/tracks.json /srv/epgg/data/data/subtleKnife/danRer10/config

cd hg19
mysql -h "localhost" -u "hguser" -p"hguser" "hg19" < "makeDb.sql"

cd ../danRer10
mysql -h "localhost" -u "hguser" -p"hguser" "danRer10" < "makeDb.sql"

cd /home
git clone https://github.com/epgg/load.git
cd load
cd hg19
mysql -h "localhost" -u "hguser" -p"hguser" "hg19" < "load.sql"

cd ../danRer10
mysql -h "localhost" -u "hguser" -p"hguser" "danRer10" < "load.sql"

cd  /srv/epgg/data/data/subtleKnife/hg19
wget http://egg.wustl.edu/d/hg19/refGene.gz
wget http://egg.wustl.edu/d/hg19/refGene.gz.tbi
wget http://egg.wustl.edu/d/hg19/gencodeV17.gz
wget http://egg.wustl.edu/d/hg19/gencodeV17.gz.tbi
wget http://egg.wustl.edu/d/hg19/xenoRefGene.gz
wget http://egg.wustl.edu/d/hg19/xenoRefGene.gz.tbi


cd  /srv/epgg/data/data/subtleKnife/danRer10
wget http://egg.wustl.edu/d/danRer10/refGene.gz
wget http://egg.wustl.edu/d/danRer10/refGene.gz.tbi
wget http://egg.wustl.edu/d/danRer10/xenoRefGene.gz
wget http://egg.wustl.edu/d/danRer10/xenoRefGene.gz.tbi
wget http://egg.wustl.edu/d/danRer10/rmsk_all.gz
wget http://egg.wustl.edu/d/danRer10/rmsk_all.gz.tbi
wget http://egg.wustl.edu/d/danRer10/cpgisland.gz
wget http://egg.wustl.edu/d/danRer10/cpgisland.gz.tbi
wget http://egg.wustl.edu/d/danRer10/gc5Base.bigWig


a2enmod cgi
a2enmod headers
service apache2 restart

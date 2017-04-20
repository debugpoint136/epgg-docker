#!/bin/bash
cd /tmp
wget http://curl.haxx.se/download/curl-7.46.0.tar.bz2
tar -xvjf curl-7.46.0.tar.bz2
cd curl-7.46.0
make
make install
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
chown www-data.www-data /srv/epgg/data/data/subtleKnife/hg19/session
mkdir -p /var/www/html/browser/t
mkdir /srv/epgg/data/trash
chown www-data.www-data /var/www/html/browser/t /srv/epgg/data/trash
ln -s /srv/epgg/data/trash /usr/lib/
cd /home/eg/browser
mv css/ index.html js/ images/ /var/www/html/browser/
cd /home/eg
cp config/treeoflife /srv/epgg/data/data/subtleKnife/
cp config/hg19/tracks.json /srv/epgg/data/data/subtleKnife/hg19/config
cp config/hg19/publichub.json /srv/epgg/data/data/subtleKnife/hg19/config
cd  /srv/epgg/data/data/subtleKnife/hg19
wget http://egg.wustl.edu/d/hg19/refGene.gz
wget http://egg.wustl.edu/d/hg19/refGene.gz.tbi
wget http://egg.wustl.edu/d/hg19/gencodeV17.gz
wget http://egg.wustl.edu/d/hg19/gencodeV17.gz.tbi
wget http://egg.wustl.edu/d/hg19/xenoRefGene.gz
wget http://egg.wustl.edu/d/hg19/xenoRefGene.gz.tbi

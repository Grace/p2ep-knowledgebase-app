#!/bin/bash

cd data
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.1.zip
sha1sum elasticsearch-5.1.1.zip
unzip elasticsearch-5.1.1.zip
rm elasticsearch-5.1.1.zip
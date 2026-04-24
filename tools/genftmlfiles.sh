#!/bin/bash

# This script rebuilds the algorithmically-generated ftml files. See README.md

# Copyright (c) 2020-2026 SIL Global  (https://www.sil.org)
# Released under the MIT License (https://opensource.org/licenses/

# Assumes we're in the root folder, i.e., font-doulos-sil-cipher

set -e

if [ ! -e OFL.txt ] 
then
	echo "Please cd to root of font project to use this script"
	exit 2
fi

prevfont="references/v1.020/DoulosSILCipher-R.ttf"
prevver="1.020"

commonParams=( \
	--prevfont "$prevfont"  \
	-s "url(../$prevfont)|$prevver"  \
	--ap '_?dia[ABO]$'  \
	--xsl ../tools/ftml.xsl  \
	--scale 200  \
	-i source/glyph_data.csv  \
	--langs 'aii,sld,syr'  \
	-w 75%  \
#	--ucdxml source/additional_ucd.xml  \
#	-s "url(../references/v1.100/EASTSM-Regular.ttf)|ref"  \
#	-s "url(../results/DoulosSILCipher-Regular.ttf)|Reg" \
)

echo "Rebuilding ftml files..."
tools/psfgenftml.py -q -t 'AllChars (auto)'                      source/masters/DoulosSILCipher-Regular.ufo  tests/AllChars-auto.ftml        -l tests/logs/AllChars.log         "${commonParams[@]}" -s 'url(../results/DoulosSILCipher-Regular.ttf)|Reg' &
tools/psfgenftml.py -q -t 'Diac Short (auto)'                    source/masters/DoulosSILCipher-Regular.ufo  tests/Diac-short-auto.ftml      -l tests/logs/DiacTest1-short.log  "${commonParams[@]}" -s 'url(../results/DoulosSILCipher-Regular.ttf)|Reg' &
tools/psfgenftml.py -q -t 'Diac (auto)'                          source/masters/DoulosSILCipher-Regular.ufo  tests/Diac-auto.ftml            -l tests/logs/DiacTest1.log        "${commonParams[@]}" -s 'url(../results/DoulosSILCipher-Regular.ttf)|Reg' & 


wait
echo done.

#!/bin/bash

dir1=${1:-.}

pmd_cpd_tokens=50
filetype='*.java'
tempfile=.all-files
outputfile='/dev/stdout'

find $dir1 -type f -name '*.java' > $tempfile
cat $tempfile | sed 's_.*/__' | sort |  uniq -d |
while read fileName
do
    # list of dupe files
    same_file_names=$(grep "/$fileName" $tempfile)

    printf "\n----\ncomparing files (pmd cpd -minimum-tokens $pmd_cpd_tokens):\n$same_file_names\n" >&2

    # do text match for 50 tokens
    res=$(pmd cpd --minimum-tokens $pmd_cpd_tokens --files $same_file_names)
    # res=
    # Found a 27 line (85 tokens) duplication in the following files: 
    # Starting at line 11 of /a/b/c/d.java
    # Starting at line 11 of /e/f/d.java

    # parse of matching tokens from res
    dupe_tokens=$(echo "$res" | sed -n 's/^.*(\([0-9]*\).*/\1/p' | awk '{s+=$1} END {print s}' )

    # parse list of matching files, find uniques due to multiple token match from pmd
    dupes=$(echo "$res" | sed -n 's/Starting at line [0-9]* of \(\)/\1/p' | sort | uniq -d)

    if [ ! -z "$dupes" ]; then
        printf "\nmatches: (filename \t tokens \t fullpath)\n\n" >&2
    fi

    # pretty print matching files
    for dupe in $dupes; do
        printf "$fileName \t $dupe_tokens \t $dupe\n"
    done
done > $outputfile

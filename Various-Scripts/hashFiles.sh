#!/bin/bash
verbose='false'
cflag='false' # check all hashes and report
rflag='false' # generate all hashes
fflag='false' # report only failed hash checks
mdfile='/mnt/cache/md5.txt'
searchDir='/mnt/*/'

# Parse Flags
while getopts 'rcfvo:' flag; do
  case "${flag}" in
    c) cflag='true' ;;
    r) rflag='true' ;;
    f) fflag='true' ;;
    v) verbose='true' ;;
    o) mdfile="${OPTARG}" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

# find -type f -print0 | parallel -0 md5sum >md5.txt
# for parallel runs

# Output some info on the flags used
if [ $verbose = true ]
then
    echo VERBOSE
fi
if [ $cflag = true ] && [ $fflag = true ]
then
  echo Report all and report failed enabled, defaulting to reporting on all checksums
fi

echo $mdfile

exit 0

# Run the intial file check generating all hashes
if [ $rflag = true ]
then
    for dir in /mnt/*/
    do
        dir=${dir%*/}
        find $dir -type f -exec md5sum {} + > $mdfile
        echo ${dir##*/}
    done
    exit 0
fi


# Check all files and report to the terminal
if [ $cflag = true ]
then

    md5sum -c $mdfile
    exit 0
fi


# Check all files and only repot FAILURES
if [ $fflag = true ]
then
    md5sum -c ~/md5.txt | grep FAILED
    exit 0
fi




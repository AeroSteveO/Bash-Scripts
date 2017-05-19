#!/bin/bash
# Still needs work, maybe, untested but in theory correct
# Takes one of a few flags for input and what to do
# -c = Check all the hashes and report EVERYTHING
# -f = Check all the hashes and report ONLY FAILURES 
# -r = Generate all the hashes (must be done before running with -c, or -f)
# -v = VERBOSE (no idea if the output will be different for this, but may come in useful in the future)
# -o = Output file to save all the hashes to, or use the hashes from


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

echo Using hashes from or saving hashes to $mdfile

# Run the intial file check generating all hashes
if [ $rflag = true ]
then
    for dir in $searchDir
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
    md5sum -c $mdfile | grep FAILED
    exit 0
fi




#!/usr/bin/env sh
# Script to link all calibre book notes to single directory

# Inspiriation
# - https://unix.stackexchange.com/questions/673235/how-do-i-write-a-script-that-creates-symbolic-links-of-files-found-inside-folder

shopt -s nullglob

srcdir=../calibre_library
destdir=../org/roam/book_notes

mkdir -p "$destdir" || exit

for pathname in "$srcdir"/*/version*.zip; do
    name=${pathname#"$srcdir"/}    # "Version 1/version1.zip"
    name=${name%/*}-${name#*/}     # "Version 1-version1.zip"

    ln -s "$PWD/$pathname" "$destdir/$name"
done

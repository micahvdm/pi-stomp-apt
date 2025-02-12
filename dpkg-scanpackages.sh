#!/bin/bash

set -e

for i in $(ls); do
    if [ "$i" = "docs" ]; then
        continue
    fi
	if [ -d $i ]; then
		cd $i
		if [ -e SKIP ]; then
			echo Copying $i deb file
			cp -f *.deb ../docs/pool/main/
			rm SKIP
		else
			echo Skipping copying $i due to no SKIP file.
		fi
		cd ..
	fi
done

dpkg-scanpackages docs/pool /dev/null > docs/dists/stable/main/binary-amd64/Packages
gzip -k -f docs/dists/stable/main/binary-amd64/Packages

git add docs
git commit -m "Updating APT package $1"
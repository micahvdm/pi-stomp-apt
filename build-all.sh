
#!/bin/bash

set -e

find . -type f -name "build-deb.sh" -exec chmod +x {} \;

for i in $(ls); do
    if [ "$i" = "docs" ]; then
        continue
    fi
	if [ -d $i ]; then
		pushd $i
		if [ ! -e SKIP ]; then
			echo Building $i...
			./build-deb.sh
			touch SKIP
		else
			echo Skipping building $i due to SKIP file.
		fi
		popd
	fi
done

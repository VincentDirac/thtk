#!/bin/bash

if [ "$1" == "" ]; then
  echo "No version given."
  exit 1
fi

releasepath=thtk-bin-$1
echo Generating $releasepath
rm -rf $releasepath
mkdir $releasepath

for i in thanm thanm.old thecl thdat thmsg thstd; do
  echo $i
  echo .ds doc-default-operating-system thtk | groff -mdoc -Tutf8 -P-buoc - $i/$i.1 | unix2dos > $releasepath/README.$i.txt
  cp build/$i/$i.exe $releasepath/
done
cp build/thtk/libthtk.dll $releasepath/
cp build/thtk/libthtk.dll.a $releasepath/
cp /d/a/_temp/msys64/ucrt64/lib/libjpeg-8.dll $releasepath/

copy_doc() {
  while [ "$1" != "" ]; do
    cat $1 | unix2dos > $releasepath/$1.txt
    shift
  done
}
copy_doc COPYING.{libpng,zlib} COPYING README NEWS

zip -r -9 $releasepath.zip $releasepath

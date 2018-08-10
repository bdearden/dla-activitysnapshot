#!/bin/sh

if ! test -f mathbook-xsl.d/mathbook-html.xsl
then
	echo "First do"
	echo "ln -s /path/to/your/mathbook/xsl mathbook-xsl.d"
	echo "before compiling."
	exit 1
fi

rm -f discover-linear-algebra-worksheets.*

xsltproc --xinclude \
  style.xsl book.xml

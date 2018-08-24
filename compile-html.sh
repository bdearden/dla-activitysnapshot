#!/bin/sh

mkdir -p /run/user/${UID}/pretext/DLA-worksheets/html/knowl
mkdir -p build
if ! test -L build/html
then
	ln -s /run/user/${UID}/pretext/DLA-worksheets/html build/html
fi

if ! test -f mathbook-xsl.d/mathbook-html.xsl
then
	echo "First do"
	echo "ln -s /path/to/your/mathbook/xsl mathbook-xsl.d"
	echo "before compiling."
	exit 1
fi

# Even though a directory is allowed as argument for --output option,
# xsltproc gives a "I/O error : Is a directory" error.
# But using a throw-away main output file avoids the error
# (and DELETEME.html is just blank after processing anyway).

xsltproc \
  --xinclude \
	--output build/html/DELETEME.html \
	style-html.xsl article-html.xml
rm -f build/html/DELETEME.html


## now compile images

BRANDLOGO=AUG-Colour.png

mkdir -p /run/user/${UID}/pretext/DLA-worksheets/html/images

/opt/mathbook/script/mbx -v -c latex-image -f svg -d build/html/images article-html.xml
if ! test -f html/images/${BRANDLOGO}
then
	cp images/${BRANDLOGO} build/html/images/
fi

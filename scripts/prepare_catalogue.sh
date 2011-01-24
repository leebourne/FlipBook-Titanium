# Script to extract the page info and links from a PDF (or multiple PDFs)
#
# Released under a Creative Commons License:
#  visit http://www.quru.com/appcelerator
#
# Syntax:
#  ./prepare_catalogue.sh <source.pdf> [target_dir]
#
# Requirements:
#  PDFTK is installed (http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/)
#  ImageMagick is installed (http://www.imagemagick.org/)

# Globals used by ImageMagick's convert utility
QUALITY=90
DENSITY=132x132
SIZE=768x1024  # iPad size
IMG_TYPE=jpg

# Either suppress logging with /dev/null or specify a log file
LOGFILE=/dev/null

if [ -z "$1" ]
then
	echo You must supply a pdf filename
	exit 1
fi

if [ -z "$2" ]
then
	TARGET_DIR="."
else
	TARGET_DIR=$2
	mkdir -p $TARGET_DIR
fi

# Split the multi-page pdf into single pages
short=${1%\.*}
printf "Extracting pages from %s                               \r" $1
pdftk "$1" burst output "$short"_%04d.pdf
rm doc_data.txt
echo pdftk "$1" burst output "$short"_%04d.pdf

# Work on each of the separate pdf pages
for pdf in "$short"_*.pdf
do
	printf "Processing %s                                          \r" $pdf
	stripped=${pdf%\.*}
	stripped=${stripped##*/}

	# Convert the pdf to a jpeg
	convert -resize $SIZE -quality $QUALITY -density $DENSITY "$pdf" "$TARGET_DIR/$stripped.$IMG_TYPE" >> $LOGFILE 2>&1

	# Extract the links (http and mailto)
	dest="$TARGET_DIR/$stripped"_links.txt
	egrep -a -A 5 "^/URI" $pdf | egrep "^/URI|^/Rect" > $dest
	if [ -s $dest ]
	then 
        	# Extract the page size information
       		egrep -a -B 5 -A 5 "^/Type /Page" "$pdf" | egrep "^/MediaBox|ArtBox|^/UserUnit" > "$TARGET_DIR/$stripped"_pageinfo.txt
	else
		# If the PDF doesn't have any links we don't need the info
		rm $dest
	fi

	# Clean up the pdfs that we don't need
#	rm $pdf
done
echo "Done                                                                "

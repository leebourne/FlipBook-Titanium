# FlipBook-Titanium
FlipBook for Titanium

This is a component to create a Flipbook to iPad.
This initial release uses images for pages. 


## Add this to you project

Copy the 'flipbook' folder inside your 'Resource' project folder.

## Basic Usage

To add on a window:

```
	// Add Flipbook Library
	Ti.include('flipbook/flipbook.js');


	// Create Flipbook Object
	flipbook.create({
		pages:['img/1.jpg','img/2.jpg','img/3.jpg','img/4.jpg','img/5.jpg'], // Add your Image Pages
		top:0,
		left:0,
		width:768,
		height:1004,
		pagesDir:Ti.Filesystem.resourcesDirectory,
		attachTo:win // ATTENTION, USE this to add object to you window instead of 'win.add(blabla);'
	});
```


That's pretty much it! Any edits/improvements are appreciated.

## Starting with a PDF
* Install PDFTK from <http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/>
* Install ImageMagick from <http://www.imagemagick.org/>
* Take a PDF and run the scripts prepare_catalogue.sh in the scripts directory against it.
* e.g. ``` scripts/prepare_catalogue.sh <your pdf name>.pdf Resources/<your pdf name>```
* Hyperlinks must be annotated correctly in the PDF, see <http://stylisticweb.com/blog/how-to-create-pdf-hyperlinks>.
* If you need to you can experiment with the image quality settings in the script. Be careful about changing the size though as the iPad is pretty slow at resizing images on the fly.
* Modify Resources/app.js and complete the values for variables 'pdfName' and 'numPages'

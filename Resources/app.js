// For help see http://www.quru.com/appcelerator/

// Your Window
var win = Ti.UI.createWindow({
	backgroundColor:'#666666'
});
win.open();


// Add Flipbook Library
Ti.include('flipbook/flipbook.js');

function pad(number, length) {
   
    var str = '' + number;
    while (str.length < length) {
        str = '0' + str;
    }
   
    return str;
}

var pageArray = [];
var numPages = 5;
var pdfName  = "img";  // Your pdf name (without the .jpg extension)
var imgType  = "jpg";  
for (curPage = 1; curPage <= numPages; curPage++)
{
	pageArray.push(pdfName + "/" + pdfName + "_" + pad(curPage, 4) + "." + imgType);
}

// Create Flipbook Object
flipbook.create({
	pages:pageArray,
	top:0,
	left:0,
	right:0,
	bottom:0,
	pagesDir:Ti.Filesystem.resourcesDirectory,
	//showButtons:false,
	//showPagination:false,
	attachTo:win // ATTENTION, USE this to add object to you window instead of 'win.add(blabla);'
});

flipbook.showPagination(false);
flipbook.showButtons(true);

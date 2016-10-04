
function moveLeft(leaveOneMsg) {
    
    if (noSelection())
    {
        return 0;
    }
    
    var formName = this.document.forms[0].selectedListElementFormName.value;
    var colNum = formName.charAt(1);
    var nextCol = colNum;
    nextCol--;
    if (colNum > 0)
    {
        var srcForm = "this.document.forms[0]." + formName;

        //This is the case where the user is trying to move the last slection out of the right hand box.
        // this number is two because the box contains the last option plus the 'spacer'
        if(eval(srcForm+".length") <= 2)
        {
          alert(leaveOneMsg);
        }
        else
        {

			var currIndex = this.document.forms[0].selectedListElementIndex.value;
			var itemName = this.document.forms[0].selectedListElementValue.value;  
			var textName = this.document.forms[0].selectedListElementText.value;                
			
			var destForm = "this.document.forms[0].C" + nextCol;
					
			eval("destIndex=" + destForm + ".length");
			var oneLess = destIndex-1;
			var oneMore = destIndex+1;
	
			eval(destForm + ".length=" + oneMore);                
			eval(destForm + ".options[" + destIndex + "].value=" + "itemName");
			eval(destForm + ".options[" + destIndex + "].text=" + "textName");
			
			swapItems(destForm, destIndex, destIndex-1, colNum);
			
			removeSelectedItem();
			removeFocus("C" + nextCol);
			
			setFocus(destForm, "C" + nextCol, oneLess, itemName, textName, true);
	
			return 0;
		}
    }
    else
    {
        return 0;
    }
        
    return 0;
        
}

function moveUp() {
    
    if (noSelection())
    {
        return 0;
    }
    
    var currIndex = this.document.forms[0].selectedListElementIndex.value;
    var formName = this.document.forms[0].selectedListElementFormName.value;
        
    if (currIndex == 0)
    {
        return 0;
    }
        
    var itemName = this.document.forms[0].selectedListElementValue.value;  
    var textName = this.document.forms[0].selectedListElementText.value;                
    var srcForm = "this.document.forms[0]." + formName;
                
    swapItems(srcForm, currIndex, currIndex-1, formName.charAt(1));
                
    setFocus(srcForm, formName, currIndex-1, itemName, textName, true);

    return 0;    
}

function moveRight() {

    if (noSelection())
    {
        return 0;
    }
        
    var formName = this.document.forms[0].selectedListElementFormName.value;
    var colNum = formName.charAt(1);
    var nextCol = colNum;
    nextCol++;
    if (nextCol < 2)
    {
        var currIndex = this.document.forms[0].selectedListElementIndex.value;
        var itemName = this.document.forms[0].selectedListElementValue.value;   
        var textName = this.document.forms[0].selectedListElementText.value;                
        var destForm = "this.document.forms[0].C" + nextCol;
        var srcForm = "this.document.forms[0]." + formName;
                
        eval("destIndex=" + destForm + ".length");
        var oneLess = destIndex-1;
        var oneMore = destIndex+1;
        
        eval(destForm + ".length=" + oneMore);                
        eval(destForm + ".options[" + destIndex + "].value=" + "itemName");
        eval(destForm + ".options[" + destIndex + "].text=" + "textName");
        
        
        swapItems(destForm, destIndex, destIndex-1, nextCol);
        
        removeSelectedItem();

        removeFocus("C" + nextCol);
        
        setFocus(destForm, "C" + nextCol, oneLess, itemName, textName, true);

        return 0;
    }
    else
    {
        return 0;
    }
    
    return 0;
}

function moveDown() {
    if (noSelection())
    {
        return 0;
    }
    
        var currIndex = this.document.forms[0].selectedListElementIndex.value;
        var formName = this.document.forms[0].selectedListElementFormName.value;
        var srcForm = "this.document.forms[0]." + formName;
        
        eval("currLength=" + srcForm + ".length");
        currLength -= 2;

        if (currIndex >= currLength)
        {
            return 0;
        }
        
        var itemName = this.document.forms[0].selectedListElementValue.value;     
        var textName = this.document.forms[0].selectedListElementText.value;        
        
        var srcForm = "this.document.forms[0]." + formName;
        destIndex = currIndex;
        destIndex++;
        swapItems(srcForm, currIndex, destIndex, formName.charAt(1));
                
        setFocus(srcForm, formName, destIndex, itemName, textName, true);

        return 0;    
}

function noSelection()
{
    var currIndex = this.document.forms[0].selectedListElementIndex.value;
    if ((currIndex.length == 0) ||  (currIndex == -1))
        return true;
    else
        return false;    
}

function swapItems(destForm, idx1, idx2, column)
{
    eval("idx1Value=" + destForm + ".options[" + idx1 + "].value");
    eval("idx1Text=" + destForm + ".options[" + idx1 + "].text");
    eval("idx2Value=" + destForm + ".options[" + idx2 + "].value");
    eval("idx2Text=" + destForm + ".options[" + idx2 + "].text");
    
    eval(destForm + ".options[" + idx1 + "].value=" + "idx2Value");
    eval(destForm + ".options[" + idx1 + "].text=" + "idx2Text");
    eval(destForm + ".options[" + idx2 + "].value=" + "idx1Value");
    eval(destForm + ".options[" + idx2 + "].text=" + "idx1Text");
    
    return 0;
}

function removeSelectedItem()
{
    
    var formName = this.document.forms[0].selectedListElementFormName.value;
    var destForm = "this.document.forms[0]." + formName;
    var removeIndex = this.document.forms[0].selectedListElementIndex.value;
    
    eval("currLength=" + destForm + ".length");
    

    for (var x = removeIndex; x < currLength-1; x++)
    {
        var idx = x;
        idx++;
        eval("mValue=" + destForm + ".options[" + idx + "].value");
        eval("mText=" + destForm + ".options[" + idx + "].text");
    
        eval(destForm + ".options[" + x + "].value=" + "mValue");
        eval(destForm + ".options[" + x + "].text=" + "mText");
        
    }
    eval(destForm + ".length=" + "currLength - 1");
    
    return 0;
}

function removeFocus(currFormName)
{
    var lastFormName = this.document.forms[0].lastSelectedListElementFormName.value; 
    if (lastFormName.length > 0)
        if (lastFormName != currFormName)    
            eval("this.document.forms[0]." + lastFormName + ".selectedIndex=-1");
    return 0;
}

function setFocus(focusForm, formName, index, itemName, textName, touched)
{
    eval( focusForm + ".selectedIndex=" + index);
    this.document.forms[0].selectedListElementIndex.value = index;
    this.document.forms[0].selectedListElementFormName.value = formName;
    this.document.forms[0].selectedListElementValue.value = itemName;
    this.document.forms[0].selectedListElementText.value = textName;    
    this.document.forms[0].lastSelectedListElementFormName.value = formName;
    
    return 0;
}

function processSelection(form, formName, selectionValue, selectionText)
{
    if (checkListElementName(selectionValue))
    {
        removeFocus(formName);
        eval("newSelectName=this.document.forms[0]." + formName + "[0].value");
        eval("newSelectText=this.document.forms[0]." + formName + "[0].text");
        
        
        eval("selectedIndex=this.document.forms[0]." + formName + ".selectedIndex");
        if (selectedIndex != 0)
        {
            setFocus("this.document.forms[0]." + formName, formName, 0, newSelectName, newSelectText, false);
        }
        else
            eval("this.document.forms[0]." + formName + ".selectedIndex=-1");
                
        return 0;
    }
    
    
    this.document.forms[0].selectedListElementIndex.value = form.selectedIndex;
    this.document.forms[0].selectedListElementFormName.value = formName;
    this.document.forms[0].selectedListElementValue.value = selectionValue;
    this.document.forms[0].selectedListElementText.value = selectionText;
    
    
    removeFocus(formName);
    this.document.forms[0].lastSelectedListElementFormName.value = formName;
    
    return 0;
    
}

function processSelectionWPrev(form, formName, selectionValue, selectionText)
{

    if (checkListElementName(selectionValue))
    {
        removeFocus(formName);
        eval("newSelectName=this.document.forms[0]." + formName + "[0].value");
        eval("newSelectText=this.document.forms[0]." + formName + "[0].text");
        
        
        eval("selectedIndex=this.document.forms[0]." + formName + ".selectedIndex");
        if (selectedIndex != 0)
        {
            setFocus("this.document.forms[0]." + formName, formName, 0, newSelectName, newSelectText, false);
        }
        else
            eval("this.document.forms[0]." + formName + ".selectedIndex=-1");
                
        return 0;
    }
    
    
    this.document.forms[0].selectedListElementIndex.value = form.selectedIndex;
    this.document.forms[0].selectedListElementFormName.value = formName;
    this.document.forms[0].selectedListElementValue.value = selectionValue;
    this.document.forms[0].selectedListElementText.value = selectionText;
    
    removeFocus(formName);
    this.document.forms[0].lastSelectedListElementFormName.value = formName;
	 showPreviewThumbnail(form);

    return 0;
    
}

function checkListElementName(theName) {
    if (theName == "spacer")
        return true;
    else
        return false;
}


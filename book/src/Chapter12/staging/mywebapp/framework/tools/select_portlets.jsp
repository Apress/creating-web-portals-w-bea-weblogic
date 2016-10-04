<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.bea.portal.admin.AdminResourceConstants" %>
<%@ page import="com.bea.portal.render.servlets.jsp.taglib.PortalTagConstants" %>
<%@ page import="com.bea.portal.model.PortletIdentifier" %>
<%@ page import="com.bea.portal.model.PortletPersonalization" %>
<%@ page import="com.bea.portal.model.PlaceholderIdentifier" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.lang.Boolean" %>

<%@ page errorPage="/framework/error/error.jsp" %>


<%-- ------------------------------------------------------------ --%>
<%-- taglibs                                                      --%>
<%-- ------------------------------------------------------------ --%>
<%@ taglib uri="webflow.tld" prefix="wf" %>
<%@ taglib uri="weblogic.tld" prefix="wl" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>
<%@ taglib uri="visitor.tld" prefix="vis" %>
<%@ taglib uri="ren.tld" prefix="ren" %>

<%@ include file="i18n_setup.inc"%>

<%  // Grab the html title string from the properties file %>
<i18n:getMessage messageName='pageTitle' id='pageTitle'/>

<%
  /* setup variables used in this page */
  String targetPageName = request.getParameter("portalPageName");

  // this attribute needs to be present because both the getunplacedportletsfor user
  // and the template.jsp require it to be there for visitor pages
  request.setAttribute(PortalTagConstants.PORTAL_PAGE, targetPageName);
  String layoutName = null;
%>

<ren:getCurrentLayout id="currentLayoutId" pageName="<%=targetPageName%>" />
<%
  if ( currentLayoutId != null )
  {
    layoutName = currentLayoutId.getName();
  }

  // create a URL that includes the webapp
  String layoutURL = "framework/layouts/" + layoutName + "/template.jsp";
  request.setAttribute("layoutURL", layoutURL);
%>

<ren:getPortletCategories id="categoriesAndPortlets" pageName="<%=targetPageName%>" />
<%
  //We just get an iterator of the category names.  These are the fully qualified names.  We then put them
  // into a list so we can sort them
  Iterator tempIt = categoriesAndPortlets.keySet().iterator();
  List categoryList = new ArrayList();
  while(tempIt.hasNext())
  {
      categoryList.add(tempIt.next());
  }

  //Get the language to sort by
  String language = (String)pageContext.findAttribute("LANGUAGE");
  //Need to pass in a language to the sort tag, so default to english
  if(language.compareTo("") == 0 || language == null)
  {
    language = "en";
  }

%>
    <%-- This tag will sort out categories for us.  Since the categories have their fully qualified names in 
         this list, by sorting them, we'll also put them in hierarchical order 
    --%>
    <ren:stringListI18nSort id='categoryListSorted' list='<%=categoryList%>' language='<%=language%>'/>
<%
  List categoryDisplayList = new ArrayList();
  String token = "/";
  String categoryName = "";
  String fullyQualifiedCategoryName = "";
  HashMap displayNameMap = new HashMap();

  //Now, we're going to loop through our list, and get the category name's ready to display
  for(int catCount=0;catCount<categoryListSorted.size();catCount++)
  {
    String parentCategory = "";
    int tokenIndex = 0;
    int depthCounter = 0;
    categoryName = (String)categoryListSorted.get(catCount);
    fullyQualifiedCategoryName = categoryName;
    tokenIndex = categoryName.indexOf(token);
    //This loop  will pick off all the parent information from the category name and keep the final parent
    while(tokenIndex != -1)
    {
      parentCategory = categoryName.substring(0,tokenIndex);
      categoryName = categoryName.substring(tokenIndex + 1, categoryName.length());
      depthCounter = depthCounter + 1;
      tokenIndex = categoryName.indexOf(token);
    }
    //For each parent category we pulled off, we'll add two spaces to the front of the name
    for(int i=0;i<depthCounter;i++) 
    {
        categoryName = "&nbsp;&nbsp;" + categoryName;
    }
    categoryDisplayList.add(categoryName);
    displayNameMap.put(categoryName, fullyQualifiedCategoryName);
  }

  //Get the list of portlets that belong to no category
  List uncategorizedPortlets = (List)categoriesAndPortlets.get(AdminResourceConstants.ROOT_PORTLETS_DIRECTORY);
  
  //We'll use this boolean to determine if we display the 'Uncategorized' option in the 
  // portlet categories drop down
  boolean noUncategorizedPortlets = false;
  if(uncategorizedPortlets != null && uncategorizedPortlets.isEmpty())
  {
      noUncategorizedPortlets = true;
  }

%>

<!-- If the 'save' button was clicked, go ahead and process the input. -->
<wl:process name="doAction" value="save">
<%
    // the portlet positions string contains portlets in the following format :
    // portletName:placeholder,portletName:placeholder........
    // We create a vector object which contains each element of the format :
    // portletName:placeholder
    String portletPositions = (String)request.getParameter("portletPositions");
    Vector portletNames = new Vector();
    StringTokenizer st = new StringTokenizer(portletPositions, ",");

    while (st.hasMoreTokens()) 
    {
        portletNames.add(st.nextToken());
    }
%>
    
    <vis:setPortletsForUser pageName="<%= targetPageName %>" portletNames="<%= portletNames %>" />
    <!-- we need to call these tags one more time to make sure we haven't got anything cached -->

    <%-- The following form and associated javascript allow for the "page forward" on a successful save --%>  
    <%
      //We only want to forward if there have been no generated errors within the tags
      String logId = (String)pageContext.getAttribute("logId");
      if(logId == null)
      {
    %>
         <SCRIPT LANGUAGE="JavaScript">
               window.location.replace("<wf:createWebflowURL namespace="tools" origin="select_layouts.jsp" event="link.back" httpsInd="http" />");
         </SCRIPT>
    <%} else {
      System.out.println("logId was not null : " + logId);
    }
    %>

</wl:process>




<!-- This is where we start the page processing -->
<html>
<head>
  <title><%=pageTitle%></title>
  <LINK REL=StyleSheet HREF="<wf:createResourceURL resource='<%=cssFile%>'/>" TYPE="text/css" MEDIA="screen">
  
  <!-- Get some constants that we'll use throughout the page from the i18n file -->
  <i18n:getMessage messageName='spacer' id='spacer'/>
  <i18n:getMessage messageName='all' id='all'/>
  
<script language="JavaScript">

      //Set up all of the javascript variables that will be used through out the page
    var unplacedPortletArray = new Array();
    var portletArray = new Array();
    var portletIdArray = new Array();
    portletIdArray[0] = "<%=all%>";
    var listBoxArray = new Array();
    var selectedListBox = null;
    var pagePortletsArray = new Array();
    var uncategorizedPortlets = new Array();

    <%-- ----------------------------------------- --%>
    <%-- Retrieve placeable portlets for this page --%>
    <%-- ----------------------------------------- --%>

    <ren:getUnplacedPortletsForUser id="it" pageName="<%= targetPageName %>" /> 
    <%
        while(it.hasNext())
        {
            PortletPersonalization pps = (PortletPersonalization)it.next();
            PlaceholderIdentifier pi = pps.getPlaceholderIdentifier();
            PortletIdentifier ppi = pps.getPortletIdentifier();
            String placeholderName = (pi == null) ? " " : pi.getName();
            
     %>
        // now add the portlet to an array
        var Portlet = new Array();
        populatePortlet(Portlet,
            '<%= ppi.getName() %>', '<%= pps.getDisplayName() %>', '<%= placeholderName %>' );

        unplacedPortletArray[unplacedPortletArray.length] = Portlet;
     <%
        }
     %>
    
    //This will place all of the portlets that belong to this page into the pagePortletsArray
    populateArray(pagePortletsArray);

    //This function goes through the hashmap that contains the ctegory and associated portlet 
    // information and places the information into a two dimensional array in javascript. The 
    // pagePortletsArray array contains arrays that represent the category and portlet information.
    // These arrays contain the category taxonomy information in the first element, then the rest of 
    // the elements are the portlets that belong to the array.
    function populateArray(portlets)
    {
<%
          //Java code that will set up the loop to load the javascript array
          Iterator tempCategoryIt = categoriesAndPortlets.keySet().iterator();
          List categoryPortlets = new ArrayList();
          String categoryValue = "";
          String portletValue = "";
          while(tempCategoryIt.hasNext())
          {
              categoryValue = (String)tempCategoryIt.next();
              categoryPortlets = (List)categoriesAndPortlets.get(categoryValue);
              Iterator categoryPortletsIt = categoryPortlets.iterator();
%>
              var categoryAndPortlets = new Array();
              //Place the category information into the first element of the array
              categoryAndPortlets[0] = "<%=categoryValue%>";
<%
              //This java code actually loops through the portlets list and loads the javascript array
              while(categoryPortletsIt.hasNext())
              {
                  portletValue = (String)categoryPortletsIt.next();
%>
                  //Now, place the portlet information into the array
                  categoryAndPortlets[categoryAndPortlets.length] = "<%=portletValue%>";
<%
              }
%>
              //Load the category/portlets array into the master array
              portlets[portlets.length] = categoryAndPortlets;
<%
          }
%>
    }

    function init()
    {
        // let us find out all the elements in the form

        for(var i=0; i < document.DataForm.elements.length; i++)
        {
            var x = document.DataForm.elements[i];
            // since this is a listbox, we try to populate the portlets
            // into this list box
            if((x.type == "select-one" || x.type == "select-multiple")
                && x.name != "<%= AdminResourceConstants.UNPOSITIONED %>" && x.name != "portletCategories")
            {
                listBoxArray[listBoxArray.length] = x;
            }
            
        }
        
        // now try to find the portlets that have not been placed
        // and put them in the "unpositioned" listbox
        storeUnplacedPortlets(document.DataForm.<%= AdminResourceConstants.UNPOSITIONED %>);

        //Set up portlet arrays that will be used later in the page
        buildPortletList();
        getUncategorizedPortlets();
    }

    // submit the form and save portlet positions
    function submitForm()
    {
        this.document.DataForm.submit();
    }


    // store the unplaced portlets in the unpositioned listbox
    function storeUnplacedPortlets(listBox)
    {

        for(var i=0; i < unplacedPortletArray.length; i++)
        {
            var portlet = unplacedPortletArray[i];
            insertOption(listBox, portlet.name, portlet.id, false);
        }   
        listBox.selectedIndex = -1;
    }

    // insert a value into the options array, moving the spacer at the bottom
    function insertOption(listBox, name, value, removeOld)
    {
        var optionArray = listBox.options;
        var spacerText = optionArray[optionArray.length-1].text;
        var spacerVal  = optionArray[optionArray.length-1].value;

        eval("optionArray[optionArray.length-1].text = name");
        eval("optionArray[optionArray.length-1].value = value");

        var option = new Option(spacerText, spacerVal);
        eval("listBox.options[optionArray.length]=option");      

        // remove the option from the origin
        if(selectedListBox != null && removeOld)
        {
            selectedListBox.options[selectedListBox.selectedIndex] = null;
            selectedListBox.selectedIndex = -1;
        }
    }

    // on selecting a placeholder - portlet, remove selections for other placeholders
    function changePortletSelection(placeholder)
    {
        if(placeholder.selectedIndex != -1 &&
           placeholder.options[placeholder.selectedIndex].value == "<%=spacer%>")
        {
           placeholder.selectedIndex = -1;
           selectedListBox = null;
        } else {
            selectedListBox = placeholder;
        }

        // now set the selected index of all list boxes to -1
        if(placeholder.name != "<%= AdminResourceConstants.UNPOSITIONED %>") {
            this.document.DataForm.<%= AdminResourceConstants.UNPOSITIONED %>.selectedIndex = -1;
        }
        
        for(var i = 0; i < listBoxArray.length; i++)
        {
            if(listBoxArray[i].name != placeholder.name) {
                listBoxArray[i].selectedIndex = -1;
            }
        }
    }

    function populatePortlet(portlet, id, name, placeholder)
    {
        portlet.id          = id;
        portlet.name        = name;
        portlet.placeholder = placeholder;
    } 

    //
    // Functions to move portlets around
    //

    // move from unpositioned to a layout list box
    function moveRight() 
    {
        //Don't do anything if there is either no portlet selected or if one is selected in the wrong box
        if (noSelection() || selectedListBox.name != "<%= AdminResourceConstants.UNPOSITIONED %>")
        {
            return 0;
        }      

        // now that we have to move, let us move this portlet to the first list box
        var targetListBox = listBoxArray[0];
        var portletId = selectedListBox.options[selectedListBox.selectedIndex].value;
        var placeholderName = targetListBox.name;

        insertOption(targetListBox, 
            selectedListBox.options[selectedListBox.selectedIndex].text, 
            selectedListBox.options[selectedListBox.selectedIndex].value,
            true);
        
        //These functions update the new placeholder info in both the portletminfo string and the 
        // master portlet array 
        changePlaceholder(portletId, placeholderName);
        updatePortletArray(portletId, placeholderName);

        return 0;
    }

    // move from a positioned listbox to unpostioned list box
    function moveLeft()
    {
        //Don't do anything if there is either no portlet selected or if one is selected in the wrong box
        if (noSelection() || selectedListBox.name == "<%= AdminResourceConstants.UNPOSITIONED %>")
        {
            return 0;
        }      

        var targetListBox = this.document.DataForm.<%= AdminResourceConstants.UNPOSITIONED %>;
        var portletId = selectedListBox.options[selectedListBox.selectedIndex].value;
        var placeholderName = targetListBox.name;

        //We only want to visually show the portlet moving if the portlet belongs to the category that 
        // the user has selected.  If the wrong category is selected for the portlet, we just remove 
        // it, visually, from the layout select box.
        if(portletBelongToCategory(selectedListBox.options[selectedListBox.selectedIndex].value))
        {
            insertOption(targetListBox, 
                selectedListBox.options[selectedListBox.selectedIndex].text, 
                selectedListBox.options[selectedListBox.selectedIndex].value,
                true);
        }
        else
        {
            // remove the option from the origin
            selectedListBox.options[selectedListBox.selectedIndex] = null;
            selectedListBox.selectedIndex = -1;
        }
        
        //These functions update the new placeholder info in both the portletminfo string and the 
        // master portlet array 
        changePlaceholder(portletId, placeholderName);
        updatePortletArray(portletId, placeholderName);

        return 0;
    }

    // move a portlet to the right within placeholders
    function moveRightInternal()
    {
        //Don't do anything if there is either no portlet selected or if one is selected in the wrong box
        if (noSelection() || selectedListBox.name == "<%= AdminResourceConstants.UNPOSITIONED %>")
        {
            return 0;
        }      

        // find the index of the current selected list box
        var index = selectedListBoxIndex();
        var portletId = selectedListBox.options[selectedListBox.selectedIndex].value;

        if(index != -1)
        {
            // find the index where you want to move the portlet
            index = (index == listBoxArray.length-2) ? 0 : index+1;
            
            var targetListBox = listBoxArray[index];
            var placeholderName = targetListBox.name;

            insertOption(targetListBox, 
                selectedListBox.options[selectedListBox.selectedIndex].text, 
                selectedListBox.options[selectedListBox.selectedIndex].value,
                true);
            
            selectedListBox = targetListBox;
            selectedListBox.selectedIndex = selectedListBox.options.length - 2;
            
            //This function updates the new placeholder info in the portlet info string
            changePlaceholder(portletId, placeholderName);
        }
        return 0;
    }

    // move a portlet to the right within placeholders
    function moveLeftInternal()
    {
        //Don't do anything if there is either no portlet selected or if one is selected in the wrong box
        if (noSelection() || selectedListBox.name == "<%= AdminResourceConstants.UNPOSITIONED %>")
        {
            return 0;
        }      

        // find the index of the current selected list box
        var index = selectedListBoxIndex();
        var portletId = selectedListBox.options[selectedListBox.selectedIndex].value;

        if(index != -1)
        {
            // find the index where you want to move the portlet
            index = (index == 0) ? listBoxArray.length-2 : index-1;
            
            var targetListBox = listBoxArray[index];
            var placeholderName = targetListBox.name;

            insertOption(targetListBox, 
                selectedListBox.options[selectedListBox.selectedIndex].text, 
                selectedListBox.options[selectedListBox.selectedIndex].value,
                true);

            selectedListBox = targetListBox;
            selectedListBox.selectedIndex = selectedListBox.options.length - 2;
            
            //This function updates the new placeholder info in the portlet info string
            changePlaceholder(portletId, placeholderName);
        }
        return 0;
    }

    function moveUp()
    {
        //Don't do anything if there is either no portlet selected or if we are already 
        // in the first postion
        if (noSelection() || selectedListBox.selectedIndex == 0)
        {
            return 0;
        }      

        // swap the value with the item before the current one.
        var currText = selectedListBox.options[selectedListBox.selectedIndex].text;
        var currVal  = selectedListBox.options[selectedListBox.selectedIndex].value;
        var swapVal = selectedListBox.options[selectedListBox.selectedIndex-1].value;

        selectedListBox.options[selectedListBox.selectedIndex].text=
            selectedListBox.options[selectedListBox.selectedIndex-1].text;

        selectedListBox.options[selectedListBox.selectedIndex].value=
            selectedListBox.options[selectedListBox.selectedIndex-1].value;

        selectedListBox.options[selectedListBox.selectedIndex-1].text=currText;
        selectedListBox.options[selectedListBox.selectedIndex-1].value=currVal;

        selectedListBox.selectedIndex--;

        
        //This function updates the new placement info in the portlet info string
        swapPortlets(currVal, swapVal);
    }

    function moveDown()
    {
        //Don't do anything if there is either no portlet selected or if we are already 
        // in the last postion
        if (noSelection() || selectedListBox.selectedIndex == selectedListBox.length-2)
        {
            return 0;
        }      

        // swap the value with the item before the current one.
        var currText = selectedListBox.options[selectedListBox.selectedIndex].text;
        var currVal  = selectedListBox.options[selectedListBox.selectedIndex].value;
        var swapVal = selectedListBox.options[selectedListBox.selectedIndex+1].value;

        selectedListBox.options[selectedListBox.selectedIndex].text=
            selectedListBox.options[selectedListBox.selectedIndex+1].text;

        selectedListBox.options[selectedListBox.selectedIndex].value=
            selectedListBox.options[selectedListBox.selectedIndex+1].value;

        selectedListBox.options[selectedListBox.selectedIndex+1].text=currText;
        selectedListBox.options[selectedListBox.selectedIndex+1].value=currVal;

        selectedListBox.selectedIndex++;
        
        //This function updates the new placement info in the portlet info string
        swapPortlets(currVal, swapVal);
    }

    //This function gets the index (among all the list boxes on the page) of the 
    // list box that is currently selected
    function selectedListBoxIndex()
    {
        if(selectedListBox == null)
            return -1;

        for(var i = 0; i < listBoxArray.length; i++)
        {
            if(listBoxArray[i].name == selectedListBox.name) {
                return i;
            }
        }
        
        return -1;
    }
    
    //This function returns true if there is no portlet selected, otherwise returns false
    function noSelection()
    {
        if (selectedListBox == null)
            return true;
        else if(selectedListBox.selectedIndex < 0)  // if not yet selected anything
            return true;    
        else 
            return false;
    }
    
    //This function builds the initial master portlet info list based on the portlet information 
    // as it is when the page loads.  It does this by looping through the list boxes on the page, 
    // and then through the options that belong to the listboxes (or portlets).  It then builds the 
    // comma separated string with the portlet name and the placeholder separated by a colon (:).  
    // Also, by going from top to bottom through the list boxes, the portlets relative position to 
    // each other is represented in the list by the top most portlet is the left most portlet in the 
    // list.
    function buildPortletList()
    {
        // we store the portlet positions a comma separated way with the format :
        // portletName1:placeholder,portletName2:placeholer.......
        // this will help us quickly create an vector to pass on to the tag

        // iterate through the list box array and find the portlets present
        var portletList = "";
        
        // add the unpositioned listbox also to the array
        listBoxArray[listBoxArray.length] = this.document.DataForm.<%= AdminResourceConstants.UNPOSITIONED %>;

        for(var i=0; i <  listBoxArray.length; i++)
        {
            var optionArray = listBoxArray[i].options;
            if(i>0 && optionArray.length > 1 && portletList != "")
            {
                portletList += ",";
            }

            for(var j=0; j <  optionArray.length-1; j++)
            {
                //While we're dealing with all of the portlets n the page, we'll also build up two 
                // arrays, one to hold the portlets that belong to the page and one that holds 
                // the portlets id's
                var Portlet = new Array();
                populatePortlet(Portlet, optionArray[j].value, optionArray[j].text, listBoxArray[i].name );
                portletArray[portletArray.length] = Portlet;
                portletIdArray[portletIdArray.length] = optionArray[j].value;
                
                //Add to the list.  Format based on the location we're adding it into
                if(j == optionArray.length-2) 
                {
                  portletList += optionArray[j].value + ":" + listBoxArray[i].name;
                } else 
                {
                  portletList += optionArray[j].value + ":" + listBoxArray[i].name + ",";
                }
            }           
        }
        this.document.DataForm.portletPositions.value = portletList;
    }

    //This function updates the master portlet info string when a portlet changes placeholders
    function changePlaceholder(portlet, placeholder)
    {
        var portletList = new String(this.document.DataForm.portletPositions.value);

        //First thing is to remove the portlet and old placeholder information.
        //We Start by getting the begining and ending indexes of the portlet/placeholder info
        var beginIndex = portletList.indexOf(portlet + ":");
        var endIndex = portletList.indexOf(",", beginIndex);

        //Now, get the substring of what we're going to remove.  We have to consider if the 
        // portlet/placeholder info is at the end of the list, there will be no comma to remove, 
        // otherwise we'll have to remove a comma with the other info.
        
        //We didn't find a comma after the string, therefore we're at the end of the list.
        if(endIndex == -1)
        {
            endIndex = portletList.length;
            //Because we're at the end of the list, we'll need to remove the previous comma.
            beginIndex = beginIndex - 1;
        }
        //Add one to remove the next comma
        else
        {
            endIndex = endIndex + 1;
        }
        var removeString = portletList.substring(beginIndex, endIndex);
        
        //Now, remove the string by doing a replace with nothing ("")
        portletList = portletList.replace(removeString, "");


        //Now, add in the new portlet/placeholder info
        //We need to find the last occurance of the placeholder we're working with and add the new
        // info right after that.  We use the ':' in the search so we are sure we find the placeholder 
        // name and not a substring of a portlet name, or other placeholder name.
        var lastPlaceholder = portletList.lastIndexOf(":" + placeholder);
        //We calculate the insert index by adding the length of the placeholder name, plus we add one 
        // for the ':' we use for the search
        var insertIndex = lastPlaceholder + placeholder.length + 1;

        //The case where we are moving a portlet to an empty placeholder.
        if(lastPlaceholder == -1)
        {
            //The case that there is only one portlet on the page.  If this is the case, we can just 
            // add the portlet/placeholder info
            if(portletList.length == 0)
            {
                portletList = portlet + ":" + placeholder;
            }
            //If there are other portlets, but none in the placeholder, we'll just add the info to 
            // the end of the list.
            else
            {
                portletList = portletList + "," + portlet + ":" + placeholder;
            }
        }
        //The case where there are other portlets in the placeholder
        else
        {
            //The case that we're adding to the end of the list
            if(portletList.indexOf(",", lastPlaceholder) == -1)
            {
                portletList = portletList + "," + portlet + ":" + placeholder;
            }
            //The case where we're adding in the middle of the list
            else
            {
                portletList = portletList.substring(0, insertIndex) + "," + portlet + ":" + placeholder + portletList.substring(insertIndex, portletList.length);
            }
        }

        //Now, reset our portlet positions variable
        this.document.DataForm.portletPositions.value = portletList;
    }

    //This function swaps two portlets within the master portlet info string.
    function swapPortlets(firstPortlet, secondPortlet)
    {
        var portletList = new String(this.document.DataForm.portletPositions.value);
        
        //First, we add a ':' onto our portlet strings.  We do this so we don't get the portlet 
        // names confused with any other substrings that might be equal to the portlet names
        firstPortlet = firstPortlet + ":";
        secondPortlet = secondPortlet + ":";

        //Next, we need to find our portlets in the portlet list
        var indexFirstPortlet = portletList.indexOf(firstPortlet);
        var indexSecondPortlet = portletList.indexOf(secondPortlet);

        //Now, we can swap the two portlet names.  We don't have to worry about placeholder info as 
        // both portlets will have to be in the same placeholder if they're switching order.
        //We have to consider which comes first in the list before we can swap.
        if(indexFirstPortlet < indexSecondPortlet)
        {
            portletList = portletList.substring(0, indexFirstPortlet) + secondPortlet + portletList.substring(indexFirstPortlet + firstPortlet.length, indexSecondPortlet) + firstPortlet + portletList.substring(indexSecondPortlet + secondPortlet.length, portletList.length);
        }
        else
        {
            portletList = portletList.substring(0, indexSecondPortlet) + firstPortlet + portletList.substring(indexSecondPortlet + secondPortlet.length, indexFirstPortlet) + secondPortlet + portletList.substring(indexFirstPortlet + firstPortlet.length, portletList.length);
        }
        //Now, reset our portlet positions variable
        this.document.DataForm.portletPositions.value = portletList;
    }

    //This function is called when the user selects a category from the drop down list.  It 
    // determines what category was selected and then passes the correct array of portlets into 
    // the filtering function
    function selectCategory()
    {
        var selectedCategory = document.DataForm.portletCategories.options[document.DataForm.portletCategories.selectedIndex].value;
        
        //If the spacer was chosen, then we'll just put them up to the "Show All" option
        if(selectedCategory == "<%=spacer%>")
        {
            document.DataForm.portletCategories.options.selectedIndex = 0;
            selectedCategory = "<%=all%>";
        }
        
        if(selectedCategory == "<%=all%>")
        {
            filterPortlets(portletIdArray);
        }
        else if(selectedCategory == "<%=AdminResourceConstants.ROOT_PORTLETS_DIRECTORY%>")
        {
            filterPortlets(uncategorizedPortlets);
        }
        else
        {
            for(i=0;i<pagePortletsArray.length;i++)
            {
                if(pagePortletsArray[i][0] == selectedCategory)
                {
                    filterPortlets(pagePortletsArray[i]);
                }
            }
        }
    }

    //This function takes in an array of portlets and then displays only those portlets in the 
    // 'Available but not Visible' select box
    function filterPortlets(portlets)
    {
        //Clear out portlets from the select box
        var optionArray = document.DataForm.<%=AdminResourceConstants.UNPOSITIONED%>.options;
        var spacerText = optionArray[optionArray.length-1].text;
        var spacerVal  = optionArray[optionArray.length-1].value;

        optionArray.length= 1;
        optionArray[0].text = spacerText;
        optionArray[0].value = spacerVal;
        
        //load select box using insertOption and Portlet object.  we have to go through these loops 
        // to get the portlet ifo from the master portlet array
        for(var i=1;i<portlets.length;i++)
        {
            for(var j=0;j<portletArray.length;j++)
            {
                if(portlets[i] == portletArray[j].id)
                {
                    if(portletArray[j].placeholder == "<%=AdminResourceConstants.UNPOSITIONED%>")
                    {
                        insertOption(document.DataForm.<%=AdminResourceConstants.UNPOSITIONED%>, portletArray[j].name, portletArray[j].id, false);
                    }
                    break;
                }
            }
        }
    }

    //This function updates placeholder info in the master portlet array
    function updatePortletArray(portletId, placeholder)
    {
        for(var i=0;i<portletArray.length;i++)
        {
            if(portletId == portletArray[i].id)
            {
                portletArray[i].placeholder = placeholder;
            }
        }
    }

    //This function determines if the portlet passed in belongs to the category that the 
    // user has selected
    function portletBelongToCategory(portletId)
    {
        var returnValue = false;
        var categoriesExist = false;
        for(var elementCount=0;elementCount<document.DataForm.elements.length;elementCount++)
        {
          if(document.DataForm[elementCount].name == "portletCategories")
          {
            categoriesExist = true;
            break;
          }
        }

        if(categoriesExist)
        {
            var selectedCategory = document.DataForm.portletCategories.options[document.DataForm.portletCategories.selectedIndex].value;
            //If the selected category is the 'Show All' category, return true since every portlet 
            // falls under this category.
            if(selectedCategory == "<%=all%>") 
            {
                returnValue = true;
            }
            //Otherwise, we need to loop through our master array, find the array that contains the 
            // selected category, and then loop through that categories portlets.  We return true if we find it.
            else
            {
    
                    for(var i=0;i<pagePortletsArray.length;i++)
                    {
                        if(pagePortletsArray[i][0] == selectedCategory)
                        {
                            for(var j=1;j<pagePortletsArray[i].length;j++)
                            {
                                if(pagePortletsArray[i][j] == portletId)
                                {
                                    returnValue = true;
                                    break;
                                }
                            }
                        }
                    }
            
            }
        }
        else
        {
            returnValue = true;
        }
        
        return returnValue;
    }

    //This functions loads the uncategorized array with portlets that belong to the 
    // root portlet directory ("portlets").
    function getUncategorizedPortlets()
    {
        //We want this array to follow the same structure where the first element represents the 
        // category the rest of the elements (portlets) belong to.
        uncategorizedPortlets[0] = "<%=AdminResourceConstants.ROOT_PORTLETS_DIRECTORY%>";
<%
        //Java code to loop through the uncategorized portlets list
        if(uncategorizedPortlets != null)
        {
            Iterator uncategorizedPortletsIt = uncategorizedPortlets.iterator();
            while(uncategorizedPortletsIt.hasNext())
            {
%>
                uncategorizedPortlets[uncategorizedPortlets.length] = "<%=uncategorizedPortletsIt.next()%>";
<%
            }
        }
%>
    }
</script>
</head>
<body onLoad="init()" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">

  <%@ include file="header.inc" %>

  <!-- This outter table has only one row with two data cells, one is used
       as spacer and the other for the main content area -->
  <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">

    <TR>
      <TD align="left" valign="top" width="30px">
        <!-- spacer cell -->
        <img src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" width="30" height="1" border="0">
      </TD>

      <TD>
        <!-- This is the user table that contains two table data cell: for the main page layout -->
        <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">
          <TR>
            <TD align="left" valign="top" colspan="3">
<%
              // Creation of message arguments
              Object[] args = new Object[] { targetPageName };
%>
              <span class="pageheader"><i18n:getMessage messageName='portalDisplay' messageArgs='<%=args%>'/></span><BR>&nbsp;<BR>
              <span class="instructions"><i18n:getMessage messageName='portalDisplaySubHead'/></span>
            </TD>
          </TR>
          <TR>
            <wf:form namespace="tools" event="link.refresh" origin="select_portlets.jsp" hide="true" method="post" name="DataForm">
<%
              //We do this check because we only want to show the drop down if there's more than one
              // category in our hashmap (if there's only one, that is the root directory and there 
              // are no 'real' categories)
              if(categoriesAndPortlets.size() > 1)
              {
%>
                <TABLE cellspacing="0" cellpadding="3" border="0" width="1%">
                  <TR>
                    <TD valign="top" width="1%">
                      <!-- Begin Tab Table -->      
                      <TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
                        <TR>
                          <!-- * START LABELS -->
                          <TD class="portletHeading" nowrap>
                            <i18n:getMessage messageName='portletCategories'/>
                          </TD>
                          <!-- * END LABELS  -->
                        </TR>
                      </TABLE>
                      <!-- End Tab Table -->
                      <select name="portletCategories" size="1" onChange='selectCategory()'>
                        <option value="<%=all%>" selected><i18n:getMessage messageName='showAll'/></option>
<%
                        if(!noUncategorizedPortlets)
                        {
%>
                          <option value="<%=AdminResourceConstants.ROOT_PORTLETS_DIRECTORY%>"><i18n:getMessage messageName='uncategorized'/></option>
<%                  
                        }
%>
                        <option value="<%=spacer%>">-----------------------------------</option>
<%                          
                        //We want to display all of the categories in the list, except for the 
                        // root category, which will be represented by the "Uncategorized" option
                        String category = null;
                        Iterator categoryIt = categoryDisplayList.iterator();
                        while(categoryIt.hasNext())
                        {
                          category = (String)categoryIt.next();
                          if(!displayNameMap.get(category).equals(AdminResourceConstants.ROOT_PORTLETS_DIRECTORY))
                          {
%>
                            <option value="<%=displayNameMap.get(category)%>"><%=category%></option>  
<%
                          }
                        }
%>
                      </select>
                    </TD>
                    <TD>
                      &nbsp;
                    </TD>
                  </TR>
                </TABLE>
<%                  
              }
%>
              <TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
                <TR>
                  <TD>
                    <TABLE>
                      <TR>
                        <TD valign="top" width="1%">
                          <!-- Begin Tab Table -->      
                          <TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
                            <TR>
                              <!-- * START LABELS -->
                              <TD class="portletHeading" nowrap>
                                <i18n:getMessage messageName='unplacedItemsLabel'/>
                              </TD>
                              <!-- * END LABELS  -->
                            </TR>
                          </TABLE>
                          <!-- End Tab Table -->
                          <select name="<%= AdminResourceConstants.UNPOSITIONED %>" size="12" onChange='changePortletSelection(this);'>
                            <option value="<%=spacer%>">-----------------------------------</option>
                          </select>
                        </TD>
                        <TD valign="center" align="center" width="1%">
                         <!-- place the arrows here -->
                         <a href="javascript:moveRight();" onClick="moveRight(); return false;"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_right_enabled.gif"%>'/>" border="0"></a>
                         <a href="javascript:isMandatory();" onClick="isMandatory(); return false;"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_left_enabled.gif"%>'/>" border="0"></a>
                        </TD>
                      </TR>
                    </TABLE>
                  </TD>
                  <TD width="94%" valign="bottom" align="center"> 
                    <!-- Begin Tab Table -->      
                    <TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
                      <TR>
                        <!-- * START LABELS -->
                        <TD class="portletHeading" nowrap>
                          <i18n:getMessage messageName='placedItemsLabel'/>
                        </TD>
                        <!-- * END LABELS  -->
                      </TR>
                    </TABLE>
                    <!-- End Tab Table -->
                    <!-- we call the internal request dispatcher to execute the template.jsp for the webapp -->
    <%
                    request.setAttribute(PortalTagConstants.RENDER_TOOLS_MODE, PortalTagConstants.VISITOR);
                    String url = "/framework/layouts/" + layoutName + "/template.jsp";
    %>
                    <jsp:include page="<%= url %>" />
      
    <%
                    //This code builds up a string, comma delimited, list of portlets that have been determined to be 
                    // mandatory for the user.
                    HashMap mandatoryHashmap = (HashMap)request.getAttribute(PortalTagConstants.MANDATORY);
                    Iterator mandatoryPortletNames = mandatoryHashmap.keySet().iterator();
                    Iterator mandatoryPortletStates = mandatoryHashmap.values().iterator();
                    String mandatoryList = "";
                    String portletId = "";
                    while(mandatoryPortletNames.hasNext())
                    {
                        portletId = (String)mandatoryPortletNames.next();
                        if(((Boolean)mandatoryPortletStates.next()).booleanValue())
                        {
                            mandatoryList = mandatoryList + portletId + ",";
                        }
                    }
    %>
      
                    <SCRIPT>
                      //This is the javascript that determines if the portlet that is being moved is mandatory, and if it is,
                      // it can't be moved
                      function isMandatory()
                      {
                          var mandatoryPortletList = "<%=mandatoryList%>";
                          if(selectedListBox != null && selectedListBox.selectedIndex != -1)
                          {
                              if( mandatoryPortletList.indexOf(selectedListBox.options[selectedListBox.selectedIndex].value) >= 0 )
                              {
                                 window.alert("<i18n:getMessage messageName='portletIsMandatory'/>");
                                 return 0;
                              }
                              else
                              {
                                return moveLeft();
                              }
                          }
                      }
                    </SCRIPT>
                  </TD>
                </TR>
                <TR>
                  <TD>
                    <a href="<wf:createWebflowURL namespace="tools" origin="select_layouts.jsp" event="link.back" httpsInd="http" />"><img src="<wf:createResourceURL resource='<%=imagesPath + "back.gif"%>'/>" border="0"></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:submitForm();"><img src="<wf:createResourceURL resource='<%=imagesPath + "save.gif"%>'/>" border="0"></a>
                  </TD>
                  <TD>
                    <div align="center"><br>
                      <table border="0" cellspacing="2" cellpadding="0">
                        <tr> 
                          <td rowspan="3" valign="middle" align="right"><span class="instructions"><i18n:getMessage messageName='movePreviousLabel'/></span></td>
                          <td align="center" valign="bottom"><span class="instructions"><i18n:getMessage messageName='moveUpLabel'/></span></td>
                          <td rowspan="3" valign="middle" align="left"><span class="instructions"><i18n:getMessage messageName='moveNextLabel'/></span></td>
                        </tr>
                        <tr> 
                          <td align="center" valign="middle"><a href="javascript:moveUp();" onClick="moveUp(); return false;"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_up_enabled.gif"%>'/>" border="0" align="bottom"></a><br>
                            <a href="javascript:moveLeftInternal();" onClick="moveLeftInternal(); return false;"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_left_enabled.gif"%>'/>" border="0" align="absmiddle"></a>&nbsp;&nbsp;&nbsp; 
                            <a href="javascript:moveRightInternal();" onClick="moveRightInternal(); return false;"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_right_enabled.gif"%>'/>" border="0" align="absmiddle"></a><br>
                            <a href="javascript:moveDown();" onClick="moveDown(); return false;"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_down_enabled.gif"%>'/>" border="0" align="top"></a> 
                          </td>
                        </tr>
                        <tr> 
                          <td align="center" valign="top"><span class="instructions"><i18n:getMessage messageName='moveDownLabel'/></span></td>
                        </tr>
                      </table>
                    </div>
                  </TD>
                </TR>
              </TABLE>
  
  
              <!-- place the layout generated text here -->
              <input type="hidden" name="portalPageName" value="<%=targetPageName%>">
              <input type="hidden" name="doAction" value="save">
              <input type="hidden" name="portletPositions" value=" ">
            </wf:form>
          </TR>
        </TABLE>
      </td>

      <TD align="left" valign="top" width="30px">
        <!-- spacer cell -->
        <img src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" width="30" height="1" border="0">
      </TD>
    </TR>
  </TABLE>


<jsp:include page="footer.jsp"/>
</body>
</html>
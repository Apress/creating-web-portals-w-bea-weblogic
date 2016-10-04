<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%-- ------------------------------------------------------------ --%>
<%-- page imports                                                 --%>
<%-- ------------------------------------------------------------ --%>
<%@ page import="com.bea.portal.model.PageState"%>
<%@ page import="com.bea.portal.model.PageIdentifier"%>
<%@ page import="com.bea.portal.admin.AdminResourceConstants" %>
<%@ page errorPage="/framework/error/error.jsp" %>

<%-- ------------------------------------------------------------ --%>
<%-- taglibs                                                      --%>
<%-- ------------------------------------------------------------ --%>
<%@ taglib uri="util.tld" prefix="util" %>
<%@ taglib uri="visitor.tld" prefix="vis" %>
<%@ taglib uri="es.tld" prefix="es" %>
<%@ taglib uri="webflow.tld" prefix="wf" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>
<%@ taglib uri="weblogic.tld" prefix="wl" %>

<%-- ------------------------------------------------------------ --%>
<%-- i18n (internationalization) and skin setup                   --%>
<%-- ------------------------------------------------------------ --%>

<%@ include file="/framework/tools/i18n_setup.inc"%>

<%  // Grab the html title sTRing from the properties file %>
<i18n:getMessage messageName='pageTitle' id='pageTitle'/>

<%-- ------------------------------------------------------------ --%>
<%-- environment setup                                            --%>
<%-- ------------------------------------------------------------ --%>
<i18n:getMessage id='leaveOneMsgTemp' messageName='leaveOne' bundleName='<%=jsFile+"list_utils"%>'/>
<%
  String leaveOneMsg = leaveOneMsgTemp;

  PageIdentifier selectedHomePageId = null;
  String selHomePageDisplayName = "";
  String selectedHomePageName = "";

  /* setup variables used in this page */
%>
  <wf:getProperty property="portalName" id="portalName" type="String" scope="request"/>

<%
 String groupPortalGroupId = "groupPortalGroupId";
 String groupPortalName = "groupPortalName";
%>

<%-- ------------------------------------------------------------ --%>
<%-- form processing                                              --%>
<%-- ------------------------------------------------------------ --%>

<!-- If the 'save' button was clicked, go ahead and process the input. -->
<wl:process name="formAction" value="update">
    <%
      // parse out the unused and available page names
      String selectedPageIds = request.getParameter( "selectedPageIds" );
      StringTokenizer selectedTokenizer = new StringTokenizer( selectedPageIds, "|" );
      ArrayList selectedPageList = new ArrayList();
      while ( selectedTokenizer.hasMoreTokens() )
      {
          String next = (String)selectedTokenizer.nextToken();
          selectedPageList.add( next );
      }

      String availablePageIds = request.getParameter( "availablePageIds" );
      StringTokenizer availableTokenizer = new StringTokenizer( availablePageIds, "|" );
      ArrayList availablePageList = new ArrayList();
      while ( availableTokenizer.hasMoreTokens() )
      {
          String next = (String)availableTokenizer.nextToken();
          availablePageList.add( next );
      }
    %>
    
    <vis:setSelectedPages availablePages='<%=availablePageList%>' selectedPages='<%=selectedPageList%>'/>
    
    <%
    String newHomePage = request.getParameter("homePageId");
    // if homePageId is not set, newHomepage has 0 length and not null
    if ( newHomePage != null && newHomePage.length() != 0 ) {
    %>
            <vis:setHomePage homePage='<%=newHomePage%>'/>
    <%
    }
    
    %>
    
    <%-- The following form and associated javascript allow for the "page forward" on a successful save --%>  
    <%
      //We only want to forward if there have been no generated errors within the tags
      String logId = (String)pageContext.getAttribute("logId");
      if(logId == null)
      {
    %>
         <SCRIPT LANGUAGE="JavaScript">
          window.location.replace("<wf:createWebflowURL namespace='tools' origin='select_portal_pages.jsp' event='link.back' httpsInd='http' />");
         </SCRIPT>
    <%}
    %>
</wl:process>


<!-- Get home page -->
<vis:getHomePage id='currentHomePageId' />
<% String currentHomePageName = null;
    if ( currentHomePageId != null )
    {
        currentHomePageName = currentHomePageId.getName();
    }
%>

    <vis:getSelectedPages id="selectedPageMap" />
<%
    //This code builds up a string, comma delimited, list of pages that have been determined to be 
    // mandatory for the user.
    HashMap mandatoryHashmap = (HashMap)pageContext.getAttribute(AdminResourceConstants.MANDATORY_PAGES);
    Iterator mandatoryPageNames = mandatoryHashmap.keySet().iterator();
    Iterator mandatoryPageStates = mandatoryHashmap.values().iterator();
    String mandatoryList = "";
    String portletId = "";
    while(mandatoryPageNames.hasNext())
    {
        String pageId = (String)mandatoryPageNames.next();
        if(((Boolean)mandatoryPageStates.next()).booleanValue())
        {
            mandatoryList = mandatoryList + pageId + ",";
        }
    }

    List pageNames = new ArrayList();
%>


<%-- ------------------------------------------------------------ --%>
<%-- begin rendering                                              --%>
<%-- ------------------------------------------------------------ --%>
<html>
<head>
  <title><%=pageTitle%></title>
  <LINK REL=StyleSheet HREF="<wf:createResourceURL resource='<%=cssFile%>'/>" TYPE="text/css" MEDIA="screen">
  <script language="JavaScript" src="<wf:createResourceURL resource='<%=jsFile+"list_utils.js"%>'/>"></script>

<script language="JavaScript">
//This is the javascript that determines if the portlet that is being moved is mandatory, and if it is,
// it can't be moved
function isMandatory(leaveOneMsg)
{
    var mandatoryPageList = "<%=mandatoryList%>";
    var selectedListBox = this.document.forms[0].C1;
    if( mandatoryPageList.indexOf(selectedListBox.options[selectedListBox.selectedIndex].value) >= 0 )
    {
       window.alert("<i18n:getMessage messageName='pageIsMandatory'/>");
       return 0;
    }
    else
    {
      return moveLeft(leaveOneMsg);
    }
}

function checkDefaultPage()
{
    if ( this.document.forms[0].selectedListElementText.value.indexOf("* ") == 0 )
    {
        alert( "<i18n:getMessage messageName='cannotMoveDefaultAlert'/>" );
        return true;
    }
    return false;
}

function initHomePage()
{
	if (document.getElementById) {
		var elem = document.getElementById("dynamicTextBlock");
		if (elem != null) {
			elem.innerHTML = "<%= currentHomePageName %>";
		}
	}
  else
  {
      //First, we want to hide all the layers
      for (var i=0; i<document.forms[0].C1.options.length; i++) {
        if (document.forms[0].C1.options[i].value != "spacer") {
          eval("document.layers."+document.forms[0].C1.options[i].value+".visibility = 'hide'");
        }
      }
      //Now, show the layer that was selected
      eval("document.layers.<%= currentHomePageName %>.visibility = 'show'");
  }

}

function setHomePageView(selectObjectId) {
  var selectObject = document.forms[0].elements[selectObjectId];
	var val = selectObject.options[selectObject.selectedIndex].value;

	if (val && val != "spacer") {
		this.document.forms[0].elements["homePageId"].value = val;

		for (var i=0; i<selectObject.options.length; i++) {
			if (selectObject.options[i].text.indexOf("* ") == 0) {
				selectObject.options[i].text = selectObject.options[i].text.substr(2);
			}
		}

		selectObject.options[selectObject.selectedIndex].text =
			"* " + selectObject.options[selectObject.selectedIndex].text;
        
        this.document.forms[0].selectedListElementValue.value = val;
        this.document.forms[0].selectedListElementText.value =
            selectObject.options[selectObject.selectedIndex].text;
	}

	if (document.getElementById) {
		var elem = document.getElementById("dynamicTextBlock");
		if (elem != null) {
			elem.innerHTML = val;
		}
	}
  else
  {
      //First, we want to hide all the layers
      for (var i=0; i<document.forms[0].C1.options.length; i++) {
        if (document.forms[0].C1.options[i].value != "spacer") {
          eval("document.layers."+document.forms[0].C1.options[i].value+".visibility = 'hide'");
        }
      }
      //Now, show the layer that was selected
      eval("document.layers."+val+".visibility = 'show'");
  }

}
  
function updateSelection(action) {

    var selectedNames = "";
    var availableNames = "";
    var selObj = document.forms[0].elements["C1"];
    var availObj = document.forms[0].elements["C0"];

	// collect the page names in the selected list and put them
	// in the selectedPageIds hidden field to be used by the tag

    // skip spacer at end of list
    for (var i=0; i<selObj.options.length-1; i++) {
        selectedNames += selObj.options[i].value;
        if (i < selObj.options.length - 2) {
            selectedNames += "|";
        }
    }

    document.forms[0].elements["selectedPageIds"].value = selectedNames;

	// collect the page names in the available list and put them
	// in the availablePageIds hidden field to be used by the tag
    for (var i=0; i<availObj.options.length-1; i++) {
        availableNames += availObj.options[i].value;
        if (i < availObj.options.length - 2) {
            availableNames += "|";
        }
    }

    document.forms[0].elements["availablePageIds"].value = availableNames;

//    this.document.forms[0].submit();
	submitForm(action);
    return true;
}

function submitForm(action) {
    document.forms[0].elements["formAction"].value = action;
    this.document.forms[0].submit();
}

</script>
</head>
<BODY onLoad="initHomePage()" background="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">

<%@ include file="header.inc"%>

<!-- This outter table has only one row with two data cells, one is used
    as spacer and the other for the main content area -->
<TABLE border="0" cellspacing="0" cellpadding="0" width="100%">

<TR>
<TD align="left" valign="top" width="30px">
<!-- spacer cell -->
</TD>

<!-- begin table for main content area -->
<TD align="left" valign="top">

  <%
    // Creation of message arguments
    Object[] args = new Object[] { portalName, groupPortalName };
  %>
  <BR>
  <span class="pageheader"><i18n:getMessage messageName='portalDisplay'/></span><BR><BR>
  <span class="instructions"><i18n:getMessage messageName='portalDisplaySubHead'/></span>
  <!-- spacer between instructions and select areas -->
  <BR><BR><BR>
  <!-- start Webflow/Pipeline enabled FORM -->
  <wf:form namespace="tools" name="mainForm" event="link.refresh" origin="select_portal_pages.jsp" hide="true" method="post">

  <%
    // number of labels in category listing header section
    int numberOfLabels = 1;
  %>

  <TABLE cellspacing="0" cellpadding="0" border="0">
    <TR>
      <TD align="left" valign="top">
    <!-- Begin Tab Table -->
        <TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
          <TR>
            <!-- * START LABELS -->
            <TD class="portletHeading" NOWRAP="true">
              <i18n:getMessage messageName='availableItemsLabel'/>
            </TD>
            <!-- * END LABELS  -->
          </TR>
        </TABLE>
    <!-- End Tab Table -->
      </TD>
      <TD>&nbsp;</TD>
      <TD align="left" valign="top">
      
    <!-- Begin Tab Table -->
        <TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
          <TR>
            <!-- * START LABELS -->
            <TD class="portletHeading" NOWRAP="true">
              <i18n:getMessage messageName='selectedItemsLabel'/>
            </TD>
            <!-- * END LABELS  -->
          </TR>
        </TABLE>
    <!-- End Tab Table -->      
      
      </TD>
      <TD>&nbsp;</TD>
    </TR>

    <TR>
      <TD colspan="<%=(numberOfLabels)%>">
    <!--AVAILABLE LIST-->
    <vis:getAvailablePages id="availPageMap" />
      <select name="C0" size="13" onChange="processSelection(this,this.name,this[selectedIndex].value,this[selectedIndex].text)">
<%
	  Object[] akeys = availPageMap.keySet().toArray();
	  
	  for (int i=0; i < akeys.length; i++) 
	  {
	      String pageName = (String)akeys[i];
	      String displayName = (String)availPageMap.get(pageName);
%>
	      <option value="<%= pageName %>"><%= displayName %></option>
<%
        pageNames.add(pageName);
	  }
%>
	  <option value="spacer">----------------------------------------</option>
       </select>
      </TD>

      <TD align="center" valign="middle">
        <!-- -->
        <table border="0" cellpadding="5">
            <TR>
                 <TD align="center" valign="bottom">
                  <a href="javascript:moveRight();" onClick="moveRight(); return false"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_right_enabled.gif"%>'/>" border="0"></a>
                 </TD>
             </TR>
             <TR>
                 <TD align="center" valign="top">
                  <a href="javascript:isMandatory(<%=leaveOneMsg%>);" onClick="if ( !checkDefaultPage() ) { isMandatory(<%=leaveOneMsg%>); } return false;"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_left_enabled.gif"%>'/>" border="0"></a>
                 </TD>
          </TR>
        </table>
        <!-- -->
      </TD>
      <TD colspan="<%=(numberOfLabels)%>">


    <!--SELECTED LIST-->
      <select name="C1" size="13" onChange="processSelection(this,this.name, this[selectedIndex].value, this[selectedIndex].text)">
<%
	  Object[] skeys = selectedPageMap.toArray();
	  String text = "";
	  for (int i=0; i < skeys.length; i++) 
	  {
	      PageState pState = (PageState)skeys[i]; 
        String pageName = pState.getPageIdentifier().getName();
	      String displayName = pState.getDisplayName();
              if ( currentHomePageName != null && currentHomePageName.equals( pageName ) ) 
	         text = "* " + displayName;
              else 
	         text = displayName;
%>
	         <option value="<%= pageName %>"><%= text %></option>
<%
	      pageNames.add(pageName);
    }
%>
	  <option value="spacer">----------------------------------------</option>
       </select>

        <!-- HIDDEN ELEMENTS HERE -->
        <input type="hidden" name="selectedListElementIndex" value="">
        <input type="hidden" name="selectedListElementFormName" value="">
        <input type="hidden" name="selectedListElementValue" value="">
        <input type="hidden" name="selectedListElementText" value="">
        <input type="hidden" name="lastSelectedListElementFormName" value="">
        <input type="hidden" name="formAction" value="">
        <input type="hidden" name="viewScope" value="group">
        <input type="hidden" name="portalName" value="<%=portalName%>">
        <input type="hidden" name="groupId" value="<%=groupPortalGroupId%>">
        <input type="hidden" name="userId" value="">
        <input type="hidden" name="selectedPageIds" value="">
        <input type="hidden" name="availablePageIds" value="">
        <input type="hidden" name="homePageId" value="<%= currentHomePageName %>">

      </TD>
      <TD align="left" valign="middle">
        <table border="0">
            <TR>
                 <TD align="center" valign="bottom">
                  <a href="javascript:moveUp();" onClick="moveUp(); return false"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_up_enabled.gif"%>'/>" border="0"></a>
                 </TD>
          </TR>
            <TR>
                 <TD align="center" valign="top">
                  <a href="javascript:moveDown();" onClick="moveDown(); return false"><img src="<wf:createResourceURL resource='<%=imagesPath + "arrow_down_enabled.gif"%>'/>" border="0"></a>
                 </TD>
          </TR>
        </table>
      </TD>
    </TR>
    <TR>
      <TD class="emptyRow">&nbsp;</TD>
    </TR>
    <TR>
      <TD>
        <a href="<wf:createWebflowURL namespace='tools' origin='select_portal_pages.jsp' event='link.back' httpsInd='http' />"><img src="<wf:createResourceURL resource='<%=imagesPath + "back.gif"%>'/>" border="0"></a>
        &nbsp;&nbsp;
        <a href="javascript:updateSelection('update');"><img src="<wf:createResourceURL resource='<%=imagesPath + "save.gif"%>'/>" border="0"></a>
      </TD>
      <TD>&nbsp;</TD>
      <TD>
        <a href="javascript:setHomePageView('C1');"><img src="<wf:createResourceURL resource='<%=imagesPath + "set_as_home.gif"%>'/>" border="0"></a>
		    <br>
        <i18n:getMessage messageName='defaultHomePage'/><BR>
		    <span id="dynamicTextBlock"></span>
        <DIV id="nav4" STYLE="visibility:hidden;">
<%
          if (pageNames != null) 
          {
            for (int i=0; i<pageNames.size(); i++) 
            {
              if (pageNames.get(i) != null)
              {
%>
                <ILAYER ID="<%=pageNames.get(i)%>" visibility="hide" style="position:absolute;"><%=pageNames.get(i)%></ILAYER>
<%
              }
            }
          }
%>
        </DIV>

      </TD>
      <TD>&nbsp;</TD>
    </TR>
  </TABLE>
      </wf:form>

</TD>
<!-- end of main content area -->
<TD align="center" valign="top" width="30px">
  <!-- spacer cell -->
</TD>
</TR>
</TABLE>
<!-- spacer between select areas and footer -->
<BR><BR><BR>
<jsp:include page="footer.jsp"/>
</BODY>
</HTML>

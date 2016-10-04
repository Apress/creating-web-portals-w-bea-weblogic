<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ page extends="com.bea.portal.jsp.JspBase"%>

<%-- ------------------------------------------------------------ --%>
<%-- page imports                                                 --%>
<%-- ------------------------------------------------------------ --%>
<%@ page import="com.bea.portal.model.LayoutDefinition"%>
<%@ page import="com.bea.p13n.util.debug.Debug"%>

<%@ page errorPage="/framework/error/error.jsp" %>


<%-- ------------------------------------------------------------ --%>
<%-- taglibs                                                      --%>
<%-- ------------------------------------------------------------ --%>
<%@ taglib uri="util.tld" prefix="util" %>
<%@ taglib uri="visitor.tld" prefix="vis" %>
<%@ taglib uri="webflow.tld" prefix="wf" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>
<%@ taglib uri="weblogic.tld" prefix="wl" %>
<%@ taglib uri="ren.tld" prefix="ren" %>

<%-- ------------------------------------------------------------ --%>
<%-- i18n (internationalization) and setup                        --%>
<%-- ------------------------------------------------------------ --%>

<%@ include file="/framework/tools/i18n_setup.inc"%>

<%-- ------------------------------------------------------------ --%>
<%-- environment setup                                            --%>
<%-- ------------------------------------------------------------ --%>
<%

  Debug debug = Debug.getInstance( __select_layouts.class );
    
  /* setup variables used in this page */
  
     if ( debug.ON )
        {
            debug.out( "request = "+request);
            java.util.Enumeration parameterNames = request.getParameterNames();
            while (parameterNames.hasMoreElements())
            {
                debug.out("wl:process parameterName = "+parameterNames.nextElement());
            }
            java.util.Map parameterMap = request.getParameterMap(); 
            java.util.Collection parameterValues = parameterMap.values();
            debug.out( "wl:process parameterValues.size() = "+parameterValues.size());
            java.util.Iterator parameterIter = parameterValues.iterator();
            while (parameterIter.hasNext())
            {
               debug.out( "wl:process parameterValue = "+parameterIter.next());
            }
        }
    String targetPageName = request.getParameter("portalPageName");
%>

<%

    // The first time this page is displayed we need to get the current layout
    // using the tag. If this page is redisplayed as a result of a save
    // then we can grab the page name from the request.
    String currentLayoutName = null;
%>

<%-- ------------------------------------------------------------ --%>
<%-- form processing                                              --%>
<%-- ------------------------------------------------------------ --%>

<!-- If the 'save' button was clicked, go ahead and process the input. -->
<wl:process name="doUpdate" value="true">
    <%
        currentLayoutName = request.getParameter("currentLayout");
        if ( debug.ON )
        {
          debug.out( "request.getParameter(layoutName) = "+currentLayoutName);
        }
    %>
    <vis:setCurrentLayout pageName="<%=targetPageName%>" layoutName="<%=currentLayoutName%>" />

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
    <%}
    %>

</wl:process>

<%
    if (currentLayoutName == null)
    {
%>
  <ren:getCurrentLayout id="currentLayoutId" pageName="<%=targetPageName%>" />
<%  
      if ( currentLayoutId != null )
      {
          currentLayoutName = currentLayoutId.getName();
      }
    }
    
    String currentLayoutThumbnail = null;
    if ( currentLayoutName != null )
    {
        currentLayoutThumbnail = "framework/layouts/" + currentLayoutName + "/thumbnail.gif";
    }
%>

<%-- ------------------------------------------------------------ --%>
<%-- begin rendering                                              --%>
<%-- ------------------------------------------------------------ --%>
<html>
<head>
  <i18n:getMessage messageName='pageTitle' id='pageTitle'/>
  <title><%=pageTitle%></title>
  <LINK REL="StyleSheet" HREF="<wf:createResourceURL resource='<%=cssFile%>'/>" TYPE="text/css" MEDIA="screen">
  
<script language="JavaScript" src="<wf:createResourceURL resource='<%=jsFile+"list_utils.js"%>'/>"></script>

<script language="JavaScript">


function showPreviewThumbnail(selectObject) {

    var val = selectObject.options[selectObject.selectedIndex].value;

    if (val && val != "spacer") {
        var src = "framework/layouts/" + val + "/thumbnail.gif";
        var img = document.images["previewImage"];

        if (img != null) {
            img.src = src;
        }

    }

}

function setCurrentDefault(selectObjectId) {

    if (noSelection())
    {
        return false;
    }
    
    var selectObject = document.forms[0].elements[selectObjectId];
    var val = selectObject.options[selectObject.selectedIndex].value;

    if (val && val != "spacer") {

        document.forms[0].elements["currentLayout"].value = val;

        var src = "framework/layouts/" + val + "/thumbnail.gif";
        
        for (var i=0; i<selectObject.options.length; i++) {
            if (selectObject.options[i].text.indexOf("* ") == 0) {
                selectObject.options[i].text = selectObject.options[i].text.substr(2);
            }
        }
        selectObject.options[selectObject.selectedIndex].text =
            "* " + selectObject.options[selectObject.selectedIndex].text;

    }
}

function doFormSubmit() {

    var txt = "";
    var selObj = document.forms[0].elements["C1"];

    // skip spacer at end of list
    for (var i=0; i<selObj.options.length-1; i++) {
        txt += selObj.options[i].value;
        if (i < selObj.options.length - 2) {
            txt += "|";
        }
    }

    document.forms[0].elements["layoutNames"].value = txt;

    this.document.forms[0].submit();
    return true;
}

</script>

</head>
<BODY background="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>">

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

  <BR>
  <span class="pageheader"><i18n:getMessage messageName='portalDisplay'/>:  
  </span><BR><BR>
  <span class="instructions"><i18n:getMessage messageName='portalDisplaySubHead'/></span>
  <!-- spacer between instructions and select areas -->
  <BR><BR><BR>
  <!-- start Webflow/Pipeline enabled FORM -->
  <wf:form namespace="tools"  event="link.refresh" origin="select_layouts.jsp" hide="true" method="post">

  <%
    // number of labels in category listing header section
    int numberOfLabels = 1;

  %>
      <TABLE cellspacing="0" cellpadding="0" border="0" >
        <TR>
          <TD>
			<TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
			  <TR><TD class="portletHeading" NOWRAP="nowrap">
					<i18n:getMessage messageName='selectedItemsLabel'/>
			      </TD>
			  </TR>
			</TABLE>
		  </TD>
		  <td>&nbsp;</td>	
		  <td>&nbsp;</td>	
        </TR>
        <TR>
          <TD>
            <vis:getAvailableLayouts id="availableLayoutsList" pageName="<%=targetPageName%>" />
              <%
                StringBuffer availNames = new StringBuffer();
    
                if (availableLayoutsList != null && availableLayoutsList.size() !=0 ) {
                  for (int i=0; i<availableLayoutsList.size(); i++) {
                    if (availableLayoutsList.get(i) != null) {
                      LayoutDefinition layoutDef = (LayoutDefinition) availableLayoutsList.get(i);
                      String displayValue = layoutDef.getIdentifier().getName();
                      String displayText = layoutDef.getDisplayName();
                      if ( currentLayoutName != null && currentLayoutName.equals( displayValue ) )
                      {
                          displayText = "* " + displayText;
                      }
                       availNames.append("<option value=\"" + displayValue + "\">" + displayText + "</option>"); 
                    }
                  }
                }
              %>
    
            <select name="C1" size="13" onChange="processSelectionWPrev(this,this.name, this[selectedIndex].value, this[selectedIndex].text)"><%=availNames.toString()%><option value="spacer">----------------------------------------</option>
            </select>
    
           </TD>
           <TD align="right" valign="middle">
           <!-- START THUMBNAIL PREVIEW -->
           &nbsp;&nbsp;
           <img id="previewImage" name="previewImage"
            src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>"
            border="0" suppress="true" width=260 height=170 >
           <!-- END THUMBNAIL PREVIEW  -->
           </TD>
		   <td></td>
         
         </TR>
         
        <TR>
          <TD>
            &nbsp;&nbsp;
            <a href="<wf:createWebflowURL namespace="tools" origin="select_layouts.jsp" event="link.back" httpsInd="http" />"><img src="<wf:createResourceURL resource='<%=imagesPath + "back.gif"%>'/>" border="0" alt="<i18n:getMessage messageName='backLabel'/>"></a>
            &nbsp;&nbsp;
            <a href="javascript:setCurrentDefault('C1');doFormSubmit();"><img src="<wf:createResourceURL resource='<%=imagesPath + "save.gif"%>'/>" border="0" alt="<i18n:getMessage messageName='saveLabel'/>"></a>
          </TD>
          <TD>
            &nbsp;&nbsp;
            <br>
            <span name="dynamicTextBlock" id="dynamicTextBlock"><b>Current Default:</b><br><%=currentLayoutName%></span>
          </TD>
          <TD align="left" valign="bottom">
          <!-- Show thumbnail for the current layout -->
            <span name="dynamicImageSource" id="dynamicImageSource"><% if ( currentLayoutThumbnail != null ) { %><img src="<%=currentLayoutThumbnail%>"><% } %></span>
          </TD>
        </TR>

  </TABLE>

  <!-- HIDDEN ELEMENTS HERE -->
  <input type="hidden" name="doUpdate" value="true">
  <input type="hidden" name="portalPageName" value="<%=targetPageName%>">
  <input type="hidden" name="layoutNames" value="">
  <input type="hidden" name="currentLayout" value="<%=currentLayoutName%>">

  <!-- These hidden fields are used by the java script -->  
  <input type="hidden" name="selectedListElementIndex" value="">
  <input type="hidden" name="selectedListElementFormName" value="">
  <input type="hidden" name="selectedListElementValue" value="">
  <input type="hidden" name="selectedListElementText" value="">
  <input type="hidden" name="lastSelectedListElementFormName" value="">
           
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

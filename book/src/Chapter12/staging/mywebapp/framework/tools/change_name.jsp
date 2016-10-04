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

   
  /* setup variables used in this page */ 
  String displayName = request.getParameter("displayName");
  String pageName = request.getParameter("pageName");
  // The first time this page is displayed we need to get the current layout
  // using the tag. If this page is redisplayed as a result of a save
  // then we can grab the page name from the request.
 
  //Used for the validated form
  String validStyle="background: white; color: black";
  String invalidStyle="color: red";
  boolean displayNameEmpty = false;
%>
  

<%-- ------------------------------------------------------------ --%>
<%-- form processing                                              --%>
<%-- ------------------------------------------------------------ --%>

<!-- If the 'save' button was clicked, go ahead and process the input. -->

<wl:process name="doUpdate" value="true">
  <%-- We only want to process the form if there was no exception with the input --%>
  <wf:getException id="exception"/>
<%
  if(exception == null)
  {
    displayName = request.getParameter("displayName");
    displayName = displayName.trim();
    if(displayName.equals(""))
    {
       displayName = request.getParameter("displayNameBackup");
       displayNameEmpty = true;
    }
    else
    {
      // The following form and associated javascript allow for the "page forward" on a successful save
      // We only want to forward if there have been no generated errors within the tags

%>
      <ren:setPageName pageName="<%= pageName %>" displayName="<%= displayName %>" />
<%
      String logId = (String)pageContext.getAttribute("logId");
      if(logId == null)
      {
%>
        <SCRIPT LANGUAGE="JavaScript">
          window.location.replace("<wf:createWebflowURL namespace="tools" origin="change_name.jsp" event="link.back" httpsInd="http" />");
        </SCRIPT>
<%
      }
    }
  }
%>
</wl:process>

<%-- ------------------------------------------------------------ --%>
<%-- begin rendering                                              --%>
<%-- ------------------------------------------------------------ --%>
<html>
<head>
  <i18n:getMessage messageName='pageTitle' id='pageTitle'/>
  <title><%=pageTitle%></title>
  <LINK REL="StyleSheet" HREF="<wf:createResourceURL resource='<%=cssFile%>'/>" TYPE="text/css" MEDIA="screen">
  
<script language="JavaScript">
function doFormSubmit() 
{
    this.document.forms[0].submit();
}

function displayNameEmpty()
{
    if(<%=displayNameEmpty%>)
    {
        alert("<i18n:getMessage messageName='blankDisplayName'/>");
        this.document.forms[0].displayName.value= "<%=cnvrtSC(displayName)%>";
    }
}
</script>

</head>
<BODY onLoad="displayNameEmpty()" background="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>">

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
      <span class="pageheader"><i18n:getMessage messageName='pageHeading'/>:  
      </span><BR><BR>
      <span class="instructions"><i18n:getMessage messageName='pageDisplaySubHead'/></span>
      <!-- spacer between instructions and select areas -->
      <BR><BR><BR>

        <TABLE cellspacing="0" cellpadding="0" border="0" >
          <TR>
            <TD>
  
          		<TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
            		<TR>
  		            <TD class="portletHeading" NOWRAP="nowrap">
  			            <i18n:getMessage messageName='changeNameLabel'/>
  		            </TD>
  		          </TR>
  		        </TABLE>
  	        </TD>
  	        <td>&nbsp;</td>	
  	        <td>&nbsp;</td>
          </TR>
  
  	      <TR>
  	        <td>
              <!-- start Webflow/Pipeline enabled validated FORM -->
              <wf:validatedForm event="link.refresh" namespace="tools"
            		applyStyle="message" messageAlign="right"
            		validStyle="<%=validStyle%>"
            		invalidStyle="<%=invalidStyle%>"
            		unspecifiedStyle="<%=validStyle%>"
              >
                <wf:text name="displayName" value="<%= displayName %>" size="15" maxlength="254" />
                <!-- HIDDEN ELEMENTS HERE -->
                <input type="hidden" name="displayNameBackup" value="<%= cnvrtSC(displayName) %>">
                <input type="hidden" name="doUpdate" value="true">
                <input type="hidden" name="pageName" value="<%=pageName%>">
                
              </wf:validatedForm>
            </td>
  	        <td>&nbsp;</td>	
  	        <td>&nbsp;</td>
  	      </TR>
  
          <TR>
            <TD>
              &nbsp;&nbsp;
              <a href="<wf:createWebflowURL namespace="tools" origin="change_name.jsp" event="link.back" httpsInd="http" />"><img src="<wf:createResourceURL resource='<%=imagesPath + "back.gif"%>'/>" border="0" alt="<i18n:getMessage messageName='backLabel'/>"></a>
              &nbsp;&nbsp;
              <a href="javascript:doFormSubmit();"><img src="<wf:createResourceURL resource='<%=imagesPath + "save.gif"%>'/>" border="0" alt="<i18n:getMessage messageName='saveLabel'/>"></a>
            </TD>
  	        <td>&nbsp;</td>	
  	        <td>&nbsp;</td>
  	      </TR>
        </TABLE>
  

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
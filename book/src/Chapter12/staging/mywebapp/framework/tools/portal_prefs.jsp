<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%-- ------------------------------------------------------------ --%>
<%-- page imports                                                 --%>
<%-- ------------------------------------------------------------ --%>
<%@ page import="com.bea.portal.model.GroupPortal"%>
<%@ page import="com.bea.portal.model.PageState"%>

<%@ page errorPage="/framework/error/error.jsp" %>

<%-- ------------------------------------------------------------ --%>
<%-- taglibs                                                      --%>
<%-- ------------------------------------------------------------ --%>
<%@ taglib uri="visitor.tld" prefix="vis" %>
<%@ taglib uri="webflow.tld" prefix="wf" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>

<%-- ------------------------------------------------------------ --%>
<%-- i18n (internationalization) and skin setup                   --%>
<%-- ------------------------------------------------------------ --%>

<%@ include file="/framework/tools/i18n_setup.inc"%>

<%-- Grab the html title string from the properties file --%>
<i18n:getMessage messageName='pageTitle' id='pageTitle'/>

<%-- ------------------------------------------------------------ --%>
<%-- begin rendering                                              --%>
<%-- ------------------------------------------------------------ --%>
<html>
<head>
  <title><%=pageTitle%></title>
  <LINK REL=StyleSheet HREF="<wf:createResourceURL resource='<%=cssFile%>'/>" TYPE="text/css" MEDIA="screen">
</head>
<BODY leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">

  <%@ include file="header.inc"%>
  <BR>

  <!-- This outter table has only one row with two data cells, one is used
       as spacer and the other for the main content area -->
  <TABLE border="0" cellspacing="0" cellpadding="0" width="100%">

    <TR>
      <TD align="left" valign="top" width="30px">
        <!-- spacer cell -->
      </TD>
  
      <!-- begin table for main content area -->
      <TD align="left" valign="top">
  
        <span class="pageheader"><i18n:getMessage messageName='portalDisplay'/></span><BR><BR>
        <span class="instructions"><i18n:getMessage messageName='portalDisplaySubHead'/></span>
        <BR><BR>
    
        <img src="<wf:createResourceURL resource='<%=imagesPath + "select_skins.gif"%>'/>" width="13" height="12" alt="" border="0" hspace="5">
        <a href="<wf:createWebflowURL namespace="tools" event="link.select_skins" httpsInd="http" />"><i18n:getMessage messageName='selectSkins'/></a><BR>
        <img src="<wf:createResourceURL resource='<%=imagesPath + "select_page_view.gif"%>'/>" width="13" height="13" alt="" border="0" hspace="5">
        <a href="<wf:createWebflowURL namespace="tools" event="link.select_portal_pages" httpsInd="http" />"><i18n:getMessage messageName='selectPages'/></a><BR>
        <BR><BR>
  
<%
        // number of labels in category listing header section
        int numberOfLabels = 4;
%>
  
      	<!-- SELECTED PAGES -->
      	<!-- Each list is a Table so if skin has an outline, we can show it -->      
        <TABLE width="100%" border="0" class="portletcontainer" cellspacing="0" cellpadding="0">
    
          <TR>
            <TD align="left" valign="top" colspan="<%=(numberOfLabels)%>">
            
              <!-- Begin Tab Table -->      
              <TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
                <TR>
                  <TD class="portletHeading" NOWRAP="true">
                    <i18n:getMessage messageName='selectedItemsSubHead'/>
                  </TD>
                </TR>
              </TABLE>
              <!-- End Tab Table -->
    
            </TD>
          </TR>
    
          <vis:getSelectedPages id="selectedPageMap"/>
<%
          Object[] keys = selectedPageMap.toArray();
          for (int i=0; i < keys.length; i++) 
          {
            PageState pState = (PageState)keys[i];
            String pid = pState.getPageIdentifier().getName();
            String dname = pState.getDisplayName();
            String extraParams="portalPageName="+pid;
	    String displayNameParam = "displayName="+java.net.URLEncoder.encode(dname)+"&pageName="+pid;
	    boolean mutable = pState.isDisplayMutable() != null ? pState.isDisplayMutable().booleanValue() : false;
%>
            <TR>
              <!-- START DETAIL ROW -->
              <TD class="row" align="left" valign="top">
                &nbsp;<%=dname%>
              </TD>
              <TD class="row" align="left" valign="top">
                <a href="<wf:createWebflowURL namespace="tools" event="link.select_layouts" httpsInd="http" extraParams="<%= extraParams %>" />">
                  <img src="<wf:createResourceURL resource='<%=imagesPath + "layouts.gif"%>'/>" vspace="2" border="0"></a><BR>
              </TD>
              <TD class="row" align="left" valign="top">
                <a href="<wf:createWebflowURL namespace="tools" event="link.select_portlets" httpsInd="http" extraParams="<%= extraParams %>" />">
                  <img src="<wf:createResourceURL resource='<%=imagesPath + "portlets.gif"%>'/>" vspace="2" border="0"></a><BR>
              </TD>

              <TD class="row" align="left" valign="top">
<%
              if(mutable)
	      {
%>	      
                <a href="<wf:createWebflowURL namespace="tools" event="link.change_name" httpsInd="http" extraParams="<%= displayNameParam %>" />">
                  <img src="<wf:createResourceURL resource='<%=imagesPath + "rename.gif"%>'/>" vspace="2" border="0"></a><BR>
<%
              } else {
%>
             &nbsp;
<%
              }
%>
              </TD>

              <!-- END DETAIL ROW -->
            </TR>
<%
          }
          if (keys.length == 0)
          {
%>
            <!-- Show the 'No Selected Pages' Message -->
            <TR>
              <TD class="row" align="left" valign="top" colspan="<%=(numberOfLabels)%>">
                &nbsp;<span class="minortext"><i18n:getMessage messageName='noSelectedPages'/></span>
              </TD>
            </TR>
<%
        	}
%>
  	
          <TR>
            <TD class="spacerRow" colspan="<%=(numberOfLabels)%>">&nbsp;</TD>
          </TR>
    	  </TABLE>
    	  <!-- End of List Table -->      
    	  <br>
    
<%
        // number of labels in category listing header section
        numberOfLabels = 1;
%>

      	<!-- UN-SELECTED PAGES -->
      	<!-- Each list is a Table so if skin has an outline, we can show it -->      
      	<TABLE width="100%" border="0" class="portletcontainer" cellspacing="0" cellpadding="0">
    
          <TR>
            <TD align="left" valign="top" colspan="<%=(numberOfLabels)%>">
              
              <!-- Begin Tab Table -->      
              <TABLE cellspacing="0" cellpadding="3" border="0" width="100%">
                <TR>
                  <TD class="portletHeading" NOWRAP="true">
                    <i18n:getMessage messageName='availableItemsSubHead'/>
                  </TD>
                </TR>
              </TABLE>
              <!-- End Tab Table -->
    
            </TD>
          </TR>
    
          <vis:getAvailablePages id="availPageMap"/>
<%
          Object[] akeys = availPageMap.keySet().toArray();
          for (int i=0; i < akeys.length; i++) 
          {
            String pid = (String)akeys[i];
            String dname = (String)availPageMap.get(pid);
            if(dname == null) dname = pid;
            String extraParams="portalPageName="+pid;
%>
            <TR>
              <!-- START DETAIL ROW -->
              <TD class="row" align="left" valign="top">
                &nbsp;<%=dname%>
              </TD>
              <!-- END DETAIL ROW -->
            </TR>
<%
          }
          if (akeys.length == 0)
          {
%>
            <!-- Show the 'No Un-Selected Pages' Message -->
            <TR>
              <TD class="row" align="left" valign="top">
                &nbsp;<span class="minortext"><i18n:getMessage messageName='noUnselectedPages'/></span>
              </TD>
            </TR>
<%
          }
%>
  
          <TR>
            <TD class="spacerRow">&nbsp;</TD>
          </TR>
    
        </TABLE>
        <!-- End of List Table -->      
  
      </TD>
      <!-- end content area -->
  
      <TD align="center" valign="top" width="30px">
        <!-- spacer cell --> &nbsp;
      </TD>
  
    </TR>
  </TABLE>
  <BR><BR><BR>

  <jsp:include page="footer.jsp"/>

</BODY>
</HTML>

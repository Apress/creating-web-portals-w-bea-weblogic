<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>
<%@ taglib uri="webflow.tld" prefix="webflow" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>

<%@ page import="com.bea.portal.model.Portal"%>
<%@ page import="com.bea.portal.model.PortalState"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortalRenderHelper"%>

<i18n:localize/>

<%@ include file="/framework/resourceURL.inc"%>
<%
    // prevent caching these pages at clients.
    response.setHeader("Cache-Control", "no-cache"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // prevents caching at proxy

    PortalState portalState = PortalRenderHelper.getPortalState(request);
%>

<html>
<head>
    <link rel="StyleSheet" href="<webflow:createResourceURL resource='<%=cssFile%>'/>" type="text/css" media="screen">
    <title><%= portalState.getDisplayName() %></title>
    <script language="JavaScript">
      <!-- hide this from older browsers  
       function openBrWindow(theURL,winName,features)
       { //v2.0
           window.open(theURL,winName,features);
       }
      // end the hiding comment -->
    </script>
</head>

<body class="homebackground" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">

<%-- Render the body of the portal - essentially we are in one of 2 modes: --%>
<%-- Horizontal or Vertical. Note: we can only be in one mode at a time,   --%>

<%
    if ( Portal.NAVBAR_ORIENTATION_VERTICAL == portalState.getNavBarOrientation() )
    {
%>
        <%@ include file="vportal.inc"%>
<%  }
    else
    {
%>
        <%@ include file="hportal.inc"%>
<%  }
%>

</body>
</html>

<!-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. -->

<%@ taglib uri="webflow.tld" prefix="wf" %>
<%@ taglib uri="util.tld" prefix="util" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>

<%@ page import="com.bea.portal.model.Portlet"%>
<%@ page import="com.bea.portal.model.PortletIdentifier"%>
<%@ page import="com.bea.portal.model.PortletState"%>
<%@ page import="com.bea.portal.appflow.PortalAppflowFactory"%>
<%@ page import="com.bea.portal.appflow.PortalRequest"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortletRenderHelper"%>

<%@ page import="com.bea.p13n.util.debug.Debug"%>

<%@ page extends="com.bea.portal.jsp.JspBase"%>

<i18n:localize/>

<%@ include file="/framework/resourceURL.inc"%>

<%
    // prevent caching these pages at clients.
    response.setHeader("Cache-Control", "no-cache"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // prevents caching at proxy

    Debug debug = Debug.getInstance( __floated_portlet.class );

    PortalRequest portalRequest = PortalAppflowFactory.getPortalRequest( request );
    PortletIdentifier portletIdentifier = portalRequest.getPortalAppflowEvent().getPortletIdentifier();
    PortletState portletState = 
        portalRequest.getPortalState().getCurrentPageState().getPortletState( portletIdentifier );

    // some rendering tags rely on this being present as an attribute in the request.
    // it represents the portlet that is currently being rendered
    request.setAttribute(PortletRenderHelper.CURRENT_PORTLET_KEY, 
                         portalRequest.getPortalAppflowEvent().getPortletIdentifier());

    if(debug.ON) 
    {
        if( portalRequest != null ) 
        {
            debug.out( "portalRequest is not NULL" );
            debug.out( "portlet identifier from the PortalRequest's PortalAppflowEvent: " + 
                       portalRequest.getPortalAppflowEvent().getPortletIdentifier());
            debug.out( "portalRequest.getPortalState().getCurrentPageState().getPageIdentifier() = " + 
                       portalRequest.getPortalState().getCurrentPageState().getPageIdentifier() );
        }
        else debug.out( "portalRequest is NULL" );
    }

    String bannerURL = portletState.getUrl( Portlet.URL_BANNER );
    String headerURL = portletState.getUrl( Portlet.URL_HEADER );
    String contentURL = portletState.getUrl( Portlet.URL_CONTENT );
    String footerURL = portletState.getUrl( Portlet.URL_FOOTER );

    String portletName = portletState.getPortletIdentifier().getName();

    if (debug.ON)
    {
        debug.out( "bannerURL: " + bannerURL );
        debug.out( "headerURL: " + headerURL );
        debug.out( "contentURL: " + contentURL );
        debug.out( "footerURL: " + footerURL );
    }

%>
<html>
<head>
    <title><%=portletName%></title>
    <link rel="StyleSheet" href="<wf:createResourceURL resource='<%=cssFile%>'/>" type="text/css" media="screen">
</head>
<body class="homebackground" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">

<!-- Begin portlet container -->
<%
        try
        {
%>
<table width="100%" class="portletcontainerBlended" cellspacing="0" cellpadding="0">
  <tr>
    <td width=100%">
        <!-- in a floated portlet, there is no titlebar -->

        <!-- Start the banner table -->
        <util:validURL url="<%=bannerURL %>">
            <table cellpadding="4" cellspacing="0" width="100%" class="portletbanner">
            <tr>
                <td class="portletbanner" width="100%">
                    <jsp:include page="<%=bannerURL%>"/>
                </td>
            </tr>
            </table>
        </util:validURL>

        <!-- Start the header table -->
        <util:validURL url="<%=headerURL %>">
            <table cellpadding="4" cellspacing="0" width="100%" class="portletheader">
            <tr>
                <td class="portletheader" width="100%">
                    <jsp:include page="<%=headerURL%>"/>
                </td>
            </tr>
            </table>
        </util:validURL>

        <!--Start the content table-->
        <util:validURL url="<%=contentURL %>">
            <table cellpadding="4" cellspacing="0" width="100%" class="portletcontent">
            <tr>
                <td class="portletcontent" width="100%" valign="middle">
                    <jsp:include page="<%=contentURL%>"/>
                </td>
            </tr>
            </table>
        </util:validURL>

        <!-- Start the footer table -->
        <util:validURL url="<%=footerURL %>">
            <table cellpadding="4" cellspacing="0" width="100%" class="portletfooter">
            <tr>
                <td class="portletfooter" width="100%">
                    <jsp:include page="<%=footerURL%>"/>
                </td>
            </tr>
            </table>
        </util:validURL>
    </td>
  </tr>
</table>
<%

        }
        catch (Exception e)
        {
%>
            <table width="100%">
			  <tr>
			    <td width="100%">
                   <i18n:getMessage messageName='portalError' bundleName='portal'/>
                </td>
              </tr>
           </table>
<%
            e.printStackTrace();    
        }
%>

</body>
</html>


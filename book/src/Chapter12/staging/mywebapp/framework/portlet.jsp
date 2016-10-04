<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ taglib uri="util.tld" prefix="util" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>

<%@ page import="com.bea.p13n.util.debug.Debug"%>
<%@ page import="com.bea.portal.model.Portlet"%>
<%@ page import="com.bea.portal.model.PortletState"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortletRenderHelper"%>

<%
    //Debug debug = Debug.getInstance( __portlet.class );

    String url = null;
    PortletState portletState = PortletRenderHelper.getPortletState( request);
%>

<%-- Begin portlet padding table. This gives us the space between each portlet --%>
<table width="100%" border="0" cellspacing="0" cellpadding="4"><tr><td width="100%">

<%-- Begin portlet container table. --%>
<%-- don't use portletcontainer class if there is no title bar --%>

<% url = portletState.getUrl(Portlet.URL_TITLEBAR); %>
<%
    if ( url == null)
    {
%>
        <table width="100%" class="portletcontainerBlended" cellspacing="0" cellpadding="0" border="0">
<%  }
    else
    {
%>
        <table width="100%" class="portletcontainer" cellspacing="0" cellpadding="0" border="0">
<%  }

    try
    {
%>
        <tr><td width="100%">

        <%-- Begin title bar --%>
        <util:validURL url="<%=url %>">
               <jsp:include page="<%=url%>"/>
        </util:validURL>
<%
        //
        // if the portlet is minimized, do not render the rest of the content
        //
        if( PortletRenderHelper.isMinimized( request ) == false ) 
        {

%>
            <%-- Start the banner table --%>
            <% url = portletState.getUrl(Portlet.URL_BANNER); %>
            <util:validURL url="<%=url %>">
                <table cellpadding="4" cellspacing="0" border="0" width="100%" class="portletbanner">
                <tr>
                    <td class="portletbanner" width="100%">
                        <jsp:include page="<%=url%>"/>
                    </td>
                </tr>
                </table>
            </util:validURL>

            <%-- Start the header table --%>
            <% url = portletState.getUrl(Portlet.URL_HEADER); %>
            <util:validURL url="<%=url %>">
                <table cellpadding="4" cellspacing="0" border="0" width="100%" class="portletheader">
                <tr>
                    <td class="portletheader" width="100%">
                        <jsp:include page="<%=url%>"/>
                    </td>
                </tr>
                </table>
            </util:validURL>

            <%-- Start the content table --%>
            <% url = portletState.getUrl(Portlet.URL_CONTENT); %>
            <util:validURL url="<%=url %>">
                <table cellpadding="4" cellspacing="0" border="0" width="100%" class="portletcontent">
                <tr>
                    <td class="portletcontent" width="100%">
                        <jsp:include page="<%=url%>"/>
                    </td>
                </tr>
                </table>
            </util:validURL>

            <%-- Start the footer --%>
            <% url = portletState.getUrl(Portlet.URL_FOOTER); %>
            <util:validURL url="<%=url %>">
                <table cellpadding="4" cellspacing="0" border="0" width="100%" class="portletfooter">
                <tr>
                    <td class="portletfooter" width="100%">
                        <jsp:include page="<%=url%>"/>
                    </td>
                </tr>
                </table>
            </util:validURL>
<%
        } // end ( minimized == false )
%>
       </td></tr>
<%  }
    catch (Exception e)
    {
        // If there was some error try not to do a partial output
        out.clearBuffer();
%>
        <tr><td>
            <i18n:getMessage messageName='portalError' bundleName='portal'/>
        </td></tr>
<%
        out.flush();
        e.printStackTrace();    
    }
%>
</table>
</td></tr>
</table>

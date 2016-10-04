<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ taglib uri="util.tld" prefix="util" %>
<%@ taglib uri="webflow.tld" prefix="webflow" %>
<%@ taglib uri="portlet.tld" prefix="portlet" %>

<%@ page import="com.bea.portal.model.Portlet"%>
<%@ page import="com.bea.portal.model.PortletState"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortletRenderHelper"%>

<%@ include file="/framework/resourceURL.inc"%>

<%
    PortletState    portletState = PortletRenderHelper.getPortletState( request);
    String          portletName  = portletState.getDisplayName();
    String          url          = null;
%>

<table class="portlettitlebar" cellpadding="0" cellspacing="0" border="0" width="100%">
  <tr>

    <%--  Create a portlet icon --%>
    <% url = portletState.getUrl(Portlet.URL_ICON); %>
    <util:validURL url="<%=url%>">
        
    <td width="1%" valign="middle"><img src="<webflow:createResourceURL resource='<%=url%>'/>" width="16" height="16" border="0" hspace="2" vspace="2" align="absmiddle"></td>
    </util:validURL>

    <td class="portlettitlebar" width="97%">&nbsp;<%=portletName%></td>

    <%--  Create a help link --%>
<%
    if (portletState.isHelpable())
    {
        url = portletState.getUrl(Portlet.URL_HELP);
%>
        <util:validURL url="<%=url%>">
            <td width="1%" valign="middle"><a target="_blank" href="<webflow:createResourceURL resource='<%=url%>'/>"> 
              <img src="<webflow:createResourceURL resource='<%=imagesPath+"portlet_help.gif"%>'/>" width="16" height="16" hspace="1" vspace="2" border="0" alt="Help" align="absmiddle"></a></td>
        </util:validURL>
<%
    }
%>

    <%--  Create a link to unminimize the portlet --%>
    <td width="1%" valign="middle"><a href="<portlet:createPortletUnminimizeURL/>"><img src="<webflow:createResourceURL resource='<%=imagesPath+"portlet_unmin.gif"%>'/>" width="16" height="16" hspace="1" vspace="2" border="0" alt="Restore" align="absmiddle"></a></td>

  </tr>
</table>

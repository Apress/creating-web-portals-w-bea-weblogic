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

    <% url = portletState.getUrl(Portlet.URL_ICON); %>
    <util:validURL url="<%=url%>">
        <td width="1%" valign="middle">
             <img src="<webflow:createResourceURL resource='<%=url%>'/>" width="16" height="16" border="0" hspace="2" vspace="2" align="absmiddle">
        </td>
    </util:validURL>

    <td width="94%" class="portlettitlebar">&nbsp;<%=portletName%></td>
<%
    if (portletState.isHelpable())
    {
        url = portletState.getUrl(Portlet.URL_HELP); 
%>
        <util:validURL url="<%=url%>">
            <td width="1%" valign="middle">
              <a target="_blank" href="<webflow:createResourceURL resource='<%=url%>'/>"> 
                <img src="<webflow:createResourceURL resource='<%=imagesPath+"portlet_help.gif"%>'/>" width="16" height="16" hspace="1" vspace="2" border="0" alt="Help" align="absmiddle"></a>
            </td>
        </util:validURL>
<%
    }
    if (PortletRenderHelper.isMaximizable(request))
    {  
%>
        <td width="1%" valign="middle"> 
            <%-- Create the link to maximize the portlet --%>
            <a href="<portlet:createPortletMaximizeURL httpsInd='http'/>">
               <img src="<webflow:createResourceURL resource='<%=imagesPath+"portlet_max.gif"%>'/>" width="16" height="16" hspace="1" vspace="2" border="0" alt="Maximize" align="absmiddle"></a>
        </td>
<%
    }
    if (request.getRemoteUser() != null)
    {
        if (PortletRenderHelper.isEditable(request))
        {  
%>
            <td width="1%" valign="middle"><a href="<portlet:createPortletEditURL httpsInd='http'/>"> 
                <img src="<webflow:createResourceURL resource='<%=imagesPath+"portlet_edit.gif"%>'/>" width="16" height="16" hspace="1" vspace="2" border="0" alt="Edit" align="absmiddle"></a>
            </td>
<%
        }
    }
    if (PortletRenderHelper.isFloatable(request))
    {  
        url   = portletState.getUrl(Portlet.URL_CONTENT);
        String  portletWindowName = portletState.getPortletIdentifier().getName();
%>
        <util:validURL url="<%=url%>">
            <% request.setAttribute( "fullscreenPortletURL", url); %>

            <td width="1%" valign="middle">
                <a href="javascript:submitForm();" 
                    onClick="openBrWindow('<portlet:createPortletFloatURL httpsInd='http'/>', 
                    '<%= portletWindowName%>', 'scrollbars=yes,width=780,height=550'); return false;"> 
                    <img src="<webflow:createResourceURL resource='<%=imagesPath+"portlet_float.gif"%>'/>" width="16" height="16" hspace="1" vspace="2" border="0" alt="Float" align="absmiddle"></a>
            </td>
        </util:validURL>
<%
    }
    if (PortletRenderHelper.isMinimizable(request))
    {  
%>
        <td width="1%" valign="middle">
            <a href="<portlet:createPortletMinimizeURL httpsInd='http'/>"> 
            <img src="<webflow:createResourceURL resource='<%=imagesPath+"portlet_min.gif"%>'/>" width="16" height="16" hspace="1" vspace="2" border="0" alt="Minimize" align="absmiddle"></a>
        </td>
<%
    }
%>
  </tr>
</table>

<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ page import="com.bea.portal.render.servlets.jsp.PortletRenderHelper"%>
<%
    // If we are logged in...
    if (request.getRemoteUser() != null)
    {
        if (PortletRenderHelper.isMaximized(request))
        {
%>
            <%@ include file="maximize_titlebar.inc"%>
<%
        }
        else if (PortletRenderHelper.isInEditMode(request))
        {
%>
            <%@ include file="edit_titlebar.inc"%>
<%
        }
        else if (PortletRenderHelper.isMinimized(request))
        {
%>
            <%@ include file="minimize_titlebar.inc"%>
<%
        }
        else
        {
%>
            <%@ include file="normal_titlebar.inc"%>
<%
        }
    }
    else
    {
        if (PortletRenderHelper.isMaximized(request))
        {
%>
            <%@ include file="maximize_titlebar.inc"%>
<%
        }
        else if (PortletRenderHelper.isMinimized(request))
        {
%>
            <%@ include file="minimize_titlebar.inc"%>
<%
        }
        else
        {
%>
            <%@ include file="normal_titlebar.inc"%>
<%
        }
    }

%>

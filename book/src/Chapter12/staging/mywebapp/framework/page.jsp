<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ taglib uri="i18n.tld" prefix="i18n" %>

<%@ page import="com.bea.portal.model.LayoutIdentifier"%>
<%@ page import="com.bea.portal.model.PortletIdentifier"%>
<%@ page import="com.bea.portal.model.PageState"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortalRenderHelper"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortletRenderHelper"%>

<%@ include file="/framework/resourceURL.inc"%>

<%
    String url = null;
    PortletIdentifier portletIdentifier = null;
    PageState pageState = null;

    //
    // Is a portlet on this page is maximized?
    //
    if ((portletIdentifier = PortalRenderHelper.getMaximizedPortlet(request)) != null)
    {
        request.setAttribute(PortletRenderHelper.CURRENT_PORTLET_KEY, portletIdentifier);
        url = "maximize.jsp";

    }
    //
    // Is a portlet on this page in edit mode?
    //
    else if ((portletIdentifier = PortalRenderHelper.getEditPortlet(request)) != null)
    {
        // A portlet on this page is in edit mode
        request.setAttribute(PortletRenderHelper.CURRENT_PORTLET_KEY, portletIdentifier);
        url = "edit.jsp";
    }
    //
    // No portlets are in edit mode or maximize, therefore
    // rendner all portlets in the current layout if there are portlets
    //
    else if (((pageState = PortalRenderHelper.getPageState(request)) != null) && 
              pageState.getPortletStates().hasNext())
    
    {
        LayoutIdentifier layout = pageState.getLayoutIdentifier();
        url = "layouts/" + layout.getName() + "/template.jsp";
    }
    //
    // No portlets are on this page, therefore
    // show a "No Portlets on this Page" message.
    //
    else
    {
%>
        <i18n:getMessage messageName='noPortlets' bundleName='page'/>
<%
    }
%>

    <%-- include the page --%>
<%
if (url != null)
{
%>
    <jsp:include page='<%= url %>' />
<%
}
%>


<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ taglib uri="util.tld" prefix="util" %>

<%@ page import="com.bea.portal.model.Portal"%>
<%@ page import="com.bea.portal.model.PortalState"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortalRenderHelper"%>

<%
    try
    {
        String footer  = portalState.getUrl(Portal.URL_FOOTER);
        String navbar  = portalState.getUrl(Portal.URL_NAVBAR_HORIZONTAL);
        String content = portalState.getUrl(Portal.URL_CONTENT);
%>
        <%-- Render the portal --%>
        <%@ include file="portal_header.inc"%>
        <jsp:include page="<%= navbar  %>"/>
        <jsp:include page="<%= content %>"/>

        <util:validURL url='<%= footer %>'>
            <jsp:include page='<%= footer  %>'/>
        </util:validURL>
<%
    }
    catch (Exception e)
    {
%>
        <table><tr><td>
            <i18n:getMessage messageName='portalError' bundleName='portal'/>
        </td></tr></table>
<%
        e.printStackTrace();
    }
%>



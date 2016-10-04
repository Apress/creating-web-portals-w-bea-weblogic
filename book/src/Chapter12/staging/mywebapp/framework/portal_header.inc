<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ taglib uri="util.tld" prefix="util" %>

<%@ page import="com.bea.portal.model.Portal"%>
<%@ page import="com.bea.portal.model.PortalState"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortalRenderHelper"%>

<%
    String header  = portalState.getUrl(Portal.URL_HEADER);
%>
    <util:validURL url='<%= header %>'>
        <jsp:include page='<%= header  %>'/>
    </util:validURL>

    <%@ include file="header_links.inc"%>

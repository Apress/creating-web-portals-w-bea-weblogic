<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ taglib uri="i18n.tld" prefix="i18n" %>
<%@ taglib uri="util.tld" prefix="util" %>

<%@ page import="com.bea.portal.model.Portal"%>
<%@ page import="com.bea.portal.model.PortalState"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortalRenderHelper"%>

<%
    try
    {
        String footer  = portalState.getUrl(Portal.URL_FOOTER);
        String navbar  = portalState.getUrl(Portal.URL_NAVBAR_VERTICAL);
        String content = portalState.getUrl(Portal.URL_CONTENT);
%>
        <%@ include file="portal_header.inc"%>
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td class="homebackground" width="1px" valign="top"><jsp:include page="<%= navbar %>" /></td>
                <td><jsp:include page="<%= content %>"/>
            </tr>
        </table>
        
        <util:validURL url='<%= footer%>'>
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

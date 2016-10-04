<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>
<%@ taglib uri="util.tld" prefix="util" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>

<%@ page import="com.bea.portal.model.Portlet"%>
<%@ page import="com.bea.portal.model.PortletState"%>
<%@ page import="com.bea.portal.render.servlets.jsp.PortletRenderHelper"%>

<%@ page import="com.bea.p13n.util.debug.Debug"%>

<%
	try
	{
   		PortletState	portletState = PortletRenderHelper.getPortletState( request);
		String			url			 = null;

    	Debug debug = Debug.getInstance( __maximize.class );

%>
        <%-- Begin padding table. --%>
        <table width="100%" cellpadding="4" cellspacing="0" border="0">
        <tr>
            <td width="100%">
		<%-- Begin maximize container table. --%>
        <table class="portletcontainer" width="100%" cellpadding="0" cellspacing="0" >
        <tr>
   			<td class="portletcontainer" width="100%">

<%
       		// Begin title bar table
			url = portletState.getUrl(Portlet.URL_TITLEBAR); 
%>
       		<util:validURL url="<%=url %>">
                   		<jsp:include page="<%=url%>"/>
       		</util:validURL>


<%          // Start the banner table
            url = portletState.getUrl(Portlet.URL_BANNER);
%>
            <util:validURL url="<%=url %>">
                <table cellpadding="4" cellspacing="0" width="100%" class="portletbanner">
                <tr>
                    <td class="portletbanner" width="100%">
                        <jsp:include page="<%=url%>"/>
                    </td>
                </tr>
                </table>
            </util:validURL>

<%
			// First try for an alternate header if one doesn't exist use the 
       		// regular header
			url =  portletState.getUrl(Portlet.URL_ALTERNATE_HEADER); 
			debug.out("Alternate header: " + url);
%>
       		<util:invalidURL url="<%=url %>">
				<% url = portletState.getUrl(Portlet.URL_HEADER); %>
       		</util:invalidURL>
       		<util:validURL url="<%=url %>">
           		<table cellpadding="4" cellspacing="0" width="100%" class="portletheader">
           		<tr>
               		<td class="portletheader" width="100%">
                  		 <jsp:include page="<%=url%>"/>
               		</td>
           		</tr>
           		</table>
       		</util:validURL>
<%
			// First try for webflow content, if that doesn't exist use the 
       		// maximize url, then the regular url...
			// TODO: get the webflow URL
			url = portletState.getUrl(Portlet.URL_MAXIMIZE);
%>
       		<util:invalidURL url="<%=url %>">
				<% url = portletState.getUrl(Portlet.URL_CONTENT); %>
       		</util:invalidURL>
       		<util:validURL url="<%=url %>">
           		<table cellpadding="4" cellspacing="0" width="100%" class="portletcontent" >
           		<tr>
               		<td class="portletcontent" width="100%">
                   		<jsp:include page="<%=url%>"/>
               		</td>
           		</tr>
           		</table>
       		</util:validURL>
<%
			// First try for an alternate footer if one doesn't exist use the 
       		// regular footer
			url = portletState.getUrl(Portlet.URL_ALTERNATE_FOOTER);
			debug.out("Alternate footer: " + url);
%>
       		<util:invalidURL url="<%=url %>">
				<% url = portletState.getUrl(Portlet.URL_FOOTER); %>
       		</util:invalidURL>
       		<util:validURL url="<%=url %>">
           		<table cellpadding="4" cellspacing="0" width="100%" class="portletfooter">
           		<tr>
               		<td class="portletfooter" width="100%">
                   		<jsp:include page="<%=url%>"/>
               		</td>
           		</tr>
           		</table>
       		</util:validURL>
   			</td>
		</tr>
		</table>
        <%-- End maximize table. --%>
            </td>
        </tr>
        </table>
        <%-- End padding table. --%>
<%
	}
	catch (Exception e)
	{
		// If there was some error try not to do a partial output
		out.clearBuffer();
%>
		<table width="100%">
		<tr><td width="100%">
            <i18n:getMessage messageName='portalError' bundleName='portal'/>
		</td></tr>
		</table>
<%
		out.flush();
		e.printStackTrace();	
    }
%>

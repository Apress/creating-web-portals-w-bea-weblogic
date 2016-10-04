<!-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. -->

<%@ page extends="com.bea.portal.jsp.JspBase"%>

<%@ taglib uri="webflow.tld" prefix="wf" %>

<%@ page import="com.bea.portal.render.servlets.jsp.taglib.PortalTagConstants"%>



<%-- ------------------------------------------------------------ --%>
<%-- i18n (internationalization) and skin setup                   --%>
<%-- ------------------------------------------------------------ --%>
<%@ include file="/framework/tools/i18n_setup.inc"%>
<%
	String resourceURL = imagesPath + "portal_footer.gif";
%>
<table align="left" width="802">
  <tr>
    <td colspan="2" height="1" width="802"></td>
  </tr>
  <tr>
	<td width="1%"><a href="http://www.bea.com" /a><img src="<wf:createResourceURL resource="<%=resourceURL%>"/>" width="801" height="50" border=0></td>
  </tr>
</table>
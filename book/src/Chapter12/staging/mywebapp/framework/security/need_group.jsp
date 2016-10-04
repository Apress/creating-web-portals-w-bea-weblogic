<%@ taglib uri="webflow.tld" prefix="webflow" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>

<%@ page import="com.bea.portal.model.GroupPortal" %>
<%@ page import="com.bea.portal.appflow.processor.security.SecurityConstants" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>

<%@ include file="/framework/resourceURL.inc"%>

<i18n:getMessage messageName='pageTitleLabel' id='pageTitle'/>
<html>
<head>
    <link rel="StyleSheet" href="<webflow:createResourceURL resource='<%=cssFile%>'/>" type="text/css" media="screen">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><%=pageTitle%></title>
</head>
<body class="homebackground" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0" >

<jsp:include page="../header.jsp"/>


<br><br>
<table class="contentbgcolor" align="center" border="0" cellspacing="0" cellpadding="30">
<tr>
<TD align="left" valign="top" width="30px">
	<%-- spacer cell --%>
	<img src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" width="30" height="1" border="0">
</TD>
<td>
	<p align="center" class="pageheader"><i18n:getMessage messageName='pageTitleLabel'/></p>
	<br>
	<i18n:getMessage messageName='instructions' id='instructions'/>
	<span class="instructions"><%=instructions%></span>

	<% String validStyle="background: white; color: black"; %>
	<% String invalidStyle="color: red"; %>

	<%-- If there was an InvalidFormDataException thrown display the message --%>
	<center><span class="errorMessage"><webflow:getException/></span></center>
	<br>

	<%-- Get the users groups --%>
	<webflow:getProperty id='portalGroups' property='<%= SecurityConstants.PSK_USERS_GROUPS %>' type='java.util.List' scope='request'/>

	<webflow:validatedForm event="button.select_group" namespace="security" httpsInd="http"
		applyStyle="message" messageAlign="right"
		validStyle="<%=validStyle%>" invalidStyle="<%=invalidStyle%>" unspecifiedStyle="<%=validStyle%>"
	>
	<p>
	  <webflow:select name='<%= SecurityConstants.PORTAL_GROUPS %>' size="3" multiple="false">
		 <% 
	        Iterator iterator = portalGroups.iterator();
		    while (iterator.hasNext())
	        {
	            GroupPortal groupPortal = (GroupPortal )iterator.next();
	            String groupPortalName  = groupPortal.getDisplayName();
	            String userGroupName    = groupPortal.getGroupIdentifier();
	     %>
	            <webflow:option value='<%= userGroupName %>'/><%= groupPortalName %>
		 <% } %>
	  </webflow:select>
	<p>
	  <i18n:getMessage messageName='buttonText' id='buttonText'/>
	  <input type="submit" value="<%=buttonText%>" name="Submit"/>

	</webflow:validatedForm>
</td>
<TD align="left" valign="top" width="30px">
	<%-- spacer cell --%>
	<img src="<wf:createResourceURL resource='<%=imagesPath + "transparent.gif"%>'/>" width="30" height="1" border="0">
</TD></tr>
</table>
<br><br>

<jsp:include page="../footer.jsp"/>

</body>
</html>


      

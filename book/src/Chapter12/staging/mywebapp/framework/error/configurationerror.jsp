<%@ page import="com.bea.p13n.appflow.webflow.SessionManager" %>
<%@ page import="com.bea.p13n.appflow.webflow.SessionManagerFactory" %>
<%@ page import="com.bea.p13n.appflow.webflow.WebflowConstants" %>
<%@ page import="com.bea.p13n.appflow.common.PipelineSession" %>


<%@ taglib uri="webflow.tld" prefix="webflow" %>

<html>
<head>
<title>configurationerror.jsp</title>
</head>

<%
PipelineSession   pSession  = SessionManagerFactory.getSessionManager().getPipelineSession(request);
String		currNamespace = (String )pSession.getContext().getCurrentNamespace();

String xmlFile =	currNamespace + ".wf";
%>

<body>

<font size="5" color="green">Webflow Configuration Error:</font>
<p>
<TABLE COLS=2 WIDTH="100%">
<TR ALIGN="left">
	<TD WIDTH="20%">XML File:</TD>
	<TD WIDTH="80%"><%= xmlFile %></TD>
</TR>
<TR ALIGN="left">
	<TD WIDTH="20%">Current Namespace:</TD>
	<TD WIDTH="80%"><%= currNamespace %></TD>
</TR>
</TABLE>

<p>
<font size="5" color="green">Configuration Error Message:</font>
<p>
<%= request.getAttribute(WebflowConstants.CONFIGURATION_EXCEPTION_MESSAGE) %>
<p>
<font size="5" color="green">Dump of pipeline Session:</font>
<%@ include file="/framework/error/pipeline.jsp" %>
<%@ include file="/framework/error/request.jsp" %>
<%@ include file="/framework/error/session.jsp" %>

</body>

<style>
</style>

</html>



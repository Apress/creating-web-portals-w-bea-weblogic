<%@ page import="com.bea.p13n.appflow.webflow.WebflowConstants" %>
<%@ page import="com.bea.p13n.appflow.webflow.SessionManagerFactory" %>
<%@ page import="com.bea.p13n.appflow.common.PipelineSession" %>

<%@ page import="com.bea.p13n.appflow.webflow.internal.configuration.WebflowConfigConstants" %>
<%@ page import="com.bea.p13n.appflow.webflow.forms.MissingFormFieldException" %>



<%@ taglib uri="webflow.tld" prefix="webflow" %>

<html>
<head>
<title>missingformdata.jsp</title>
</head>

<%
PipelineSession   pSession  = SessionManagerFactory.getSessionManager().getPipelineSession(request);
String		currNamespace = (String )pSession.getContext().getCurrentNamespace();

String xmlFile       = "webflow_" + currNamespace + ".xml";
//String ip            = (String)request.getAttribute(WebflowConstants.PROCESSOR_NAME_ATTRIB);
String className     = (String)request.getAttribute(WebflowConfigConstants.JAVACLASSNAME);

%>

<body>

<font size="5" color="red">Missing HTML Form Field:</font>
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
<%--
<TR ALIGN="left">
	<TD WIDTH="20%">Input Processor:</TD>
	<TD WIDTH="80%"><%= ip %></TD>
</TR>
--%>
<TR ALIGN="left">
	<TD WIDTH="20%">Class Name:</TD>
	<TD WIDTH="80%"><%= className %></TD>
</TR>
<TR ALIGN="left">
	<TD WIDTH="20%">Origin:</TD>
	<TD WIDTH="80%"><%=  request.getParameter(WebflowConstants.ORIGIN_PARAM) %></TD>
</TR>

</TABLE>

<p>
<font size="5" color="green">MissingFormDataException Message:</font>
<p>
<font size="4" color="black"><webflow:getException/></font>
<p>
<%@ include file="/framework/error/parameters.jsp" %>

</body>

<style>
</style>

</html>



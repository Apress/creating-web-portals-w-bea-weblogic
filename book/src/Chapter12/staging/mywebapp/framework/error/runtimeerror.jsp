<%-- ############################################################ --%>
<%--                                                              --%>
<%--  This is a generic JSP for handling runtime errors. This     --%>
<%--  JSP is meant to be used for development purposes only.      --%>
<%--  A production version would display a more customer          --%>
<%--  friendly message.                                           --%>
<%--                                                              --%>
<%-- ############################################################ --%>

<%@ page import="com.bea.p13n.appflow.webflow.SessionManager" %>
<%@ page import="com.bea.p13n.appflow.webflow.SessionManagerFactory" %>
<%@ page import="com.bea.p13n.appflow.webflow.WebflowConstants" %>
<%@ page import="com.bea.p13n.appflow.common.PipelineSession" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="webflow.tld" prefix="webflow" %>

<html>

<head>
<title>Runtime Error</title>
</head>

<%
PipelineSession   pSession  = SessionManagerFactory.getSessionManager().getPipelineSession(request);
%>

<body>
<p>
<font size="5" color="darkred"> 
Runtime Error...
</font>
<p>
<%-- If there was an Exception thrown display the message --%>
<font size="4" color="black"><webflow:getException/></font>

<p>
<font size="5" color="darkred"> 
Stack Trace...
<p>
</font>
<webflow:getException id='theException'/>
<%
if (theException != null)
{
    theException.printStackTrace(new java.io.PrintStream((java.io.OutputStream)response.getOutputStream()));
}
%>
<p>
<font size="5" color="darkred">Check the log for errors...</font>
<p>
<font size="5" color="darkred">Request, Session, PipelineSession dump...</font>
<p>

<%-- Dump of request attributes, request parameters, http session and pipeline session --%>
<%@ include file="/framework/error/request.jsp" %>
<%@ include file="/framework/error/parameters.jsp" %>
<%@ include file="/framework/error/session.jsp" %>
<%@ include file="/framework/error/pipeline.jsp" %>


</body>
</html>



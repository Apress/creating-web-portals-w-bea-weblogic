<%@ page import="com.bea.portal.appflow.processor.security.Security"%>

<%@ taglib uri="webflow.tld" prefix="webflow" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>
 
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

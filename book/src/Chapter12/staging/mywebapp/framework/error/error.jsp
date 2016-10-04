<!-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. -->


<%@ taglib uri="i18n.tld" prefix="i18n" %>
<%@ taglib uri="webflow.tld" prefix="wf" %>

<%@ page isErrorPage="true" %>

<%-- ------------------------------------------------------------ --%>
<%-- i18n (internationalization) and skin setup                   --%>
<%-- ------------------------------------------------------------ --%>

<%@ include file="/framework/tools/i18n_setup.inc"%>

<%-- If it is a new session, then we go to the sessiontimeout page --%>
<%
    if(session.isNew())
    {
%>
        <jsp:forward page="/framework/error/sessiontimeout.jsp" />
<%
    }
%>

<html>
<head>
  <title><i18n:getMessage messageName='pageTitle'/></title>
  <LINK REL=StyleSheet HREF="<wf:createResourceURL resource='<%=cssFile%>'/>" TYPE="text/css" MEDIA="screen">
</head>

<body>

<jsp:include page="header.jsp" />

<i18n:getMessage messageName='anErrorOccurred'/>
<pre>
<%= weblogic.utils.StackTraceUtils.throwable2StackTrace(exception) %>
</pre>

<jsp:include page="footer.jsp" />

</body>
</html>






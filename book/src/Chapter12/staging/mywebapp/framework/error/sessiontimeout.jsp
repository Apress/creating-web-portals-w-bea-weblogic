<!-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. -->
<%@ taglib uri="i18n.tld" prefix="i18n" %>
<%@ taglib uri="webflow.tld" prefix="wf" %>

<%@ page isErrorPage="true" %>
<%@ page extends="com.bea.portal.jsp.JspBase"%>

<%-- ------------------------------------------------------------ --%>
<%-- i18n (internationalization) and skin setup                   --%>
<%-- ------------------------------------------------------------ --%>

<%@ include file="/framework/tools/i18n_setup.inc"%>

<html>
<head>
  <title><i18n:getMessage messageName='pageTitle'/></title>
  <LINK REL=StyleSheet HREF="<wf:createResourceURL resource='<%=cssFile%>'/>" TYPE="text/css" MEDIA="screen">
</head>
<BODY class="homebackground" leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">

<jsp:include page="header.jsp"/>

&nbsp;&nbsp;
<span class="pageheader"><i18n:getMessage messageName='sessionTimedOut'/></span>
<br>
<br>
<span class="instructions"><i18n:getMessage messageName='sessionTimeOutInstructions'/></span>
<br>
<jsp:include page="footer.jsp"/>

</body>
</html>

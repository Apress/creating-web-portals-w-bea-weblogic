<%@ taglib uri="webflow.tld" prefix="webflow" %>
<%@ taglib uri="portal.tld" prefix="portal" %>
<%@ taglib uri="i18n.tld" prefix="i18n" %>

<%@ include file="/framework/resourceURL.inc"%>

<i18n:getMessage messageName='pageTitleLabel' id='pageTitle'/>
<html>
<head>
    <link rel="StyleSheet" href="<webflow:createResourceURL resource='<%=cssFile%>'/>" type="text/css" media="screen">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><%=pageTitle%></title>
</head>
<body leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0" >

<jsp:include page="../header.jsp"/>

<center>
<br><br>
<i18n:getMessage messageName='title' id='title'/>
<span class="pageHeader"><%=title%></span>
<p>
<p>

<% String validStyle="background: white; color: black"; %>
<% String invalidStyle="color: red"; %>

<%-- If there was an InvalidFormDataException thrown display the message --%>
<span class="errorMessage"><webflow:getException/></span>
<br>

<webflow:validatedForm event="button.go" namespace="user_account"
		applyStyle="message" messageAlign="right"
		validStyle="<%=validStyle%>"
		invalidStyle="<%=invalidStyle%>"
		unspecifiedStyle="<%=validStyle%>"
>
<table border=0>
  <tr>
	<i18n:getMessage messageName='userId' id='userId'/>
    <td><b><%=userId%></b></td>
    <td><webflow:text name="j_username" size="15" maxlength="30" /></td>
  </tr>
  <tr>
	<i18n:getMessage messageName='password' id='password'/>
    <td><b><%=password%></b></td>
    <td><webflow:password name="j_password" size="15" retainValue="true" maxlength="30" /></td>
  </tr>
  <tr>
    <td><b><%=password%></b></td>
    <td><webflow:password name="password2" size="15" retainValue="true" maxlength="30" /></td>
  </tr>
  <tr>
	<i18n:getMessage messageName='back' id='back'/>
    <td><b><a href="<webflow:createWebflowURL namespace="security" event="link.login" />"><%=back%></a></b></td>
	<i18n:getMessage messageName='submit' id='submit'/>
    <td><input type="submit"  name="Submit" value="<%=submit%>"/></td>
  </tr>
</table>

</webflow:validatedForm>
</center>
<br><br><br>
<jsp:include page="../footer.jsp"/>
</body>
</html>


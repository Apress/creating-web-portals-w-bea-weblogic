<%@ taglib uri="webflow.tld" prefix="webflow" %>

<%@ include file="/framework/resourceURL.inc"%>

<html>
<head>
    <link rel="StyleSheet" href="<webflow:createResourceURL resource='<%=cssFile%>'/>" type="text/css" media="screen">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Login Help</title>
</head>

<body leftmargin="0" rightmargin="0" marginwidth="0" marginheight="0">

<jsp:include page="../header.jsp"/>

<table cellspacing="0" cellpadding="10" width="100%">
<tr>
<td>
<font class="contentheading">Login Help</font>
<p>
<b>What does "Remember ID & Password" mean?</b>
<br>
When you sign in using your Portal ID and password, your browser can "remember" this information. If you check the "Remember" box, you won't have to sign in each time you come back. (Although we may ask you to re-enter your password if you've been away from the computer for a while.) 
Important: Always remember your Portal ID and password or write them down in a safe place. As we may ask you for it again
when your "remebered" one expires. 
<p>
<b>Should I check it or not?</b>
<br>
If you're concerned that other people might accidentally see your personalized Portal pages, don't check the "Remember My ID & Password" box. Make sure to close your browser or click "Sign Out" when you leave your computer. This will ensure that we ask for your Portal ID and password the next time you access any of Portal's personalized services.

If you use a shared computer (in a library, Internet cafe, university, airport, or other common area) do not check the "Remember My ID & Password" checkbox. 
<p>
<b>What if I change my mind?</b>
<br>
You can sign out of Portal's personalized services at any time by clicking the "Sign Out" link at the top of each personalized Portal page. Once you've signed out, you can sign in again and choose whether your browser "remembers" or not.
<p>
<b>How does this work?</b>
<br>
We do this with something called a persistent cookie. The username and password are encrypted first before
writing the cookie to your hard drive
<br> 
<p>
<b><a href="<webflow:createWebflowURL namespace="security" event="link.back" />">Back</a></b>
</td>
</tr>
</table>
<p>
<jsp:include page="../footer.jsp"/>
</body>
</html>
      

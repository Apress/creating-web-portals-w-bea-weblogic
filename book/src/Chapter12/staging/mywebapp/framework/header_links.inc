<%-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. --%>

<%@ taglib uri="webflow.tld" prefix="webflow" %>

<table width="100%" border="0" cellspacing="0" cellpadding="1">
<tr>
<%  
    if (request.getRemoteUser() != null)
    {
%>
        <td class="titlebar" align="right">
            <a href="<webflow:createWebflowURL namespace='tools' origin='portal.jsp' event='link.customize'/>">
<img src="<webflow:createResourceURL resource='<%=imagesPath + "customize.gif"%>'/>" border="0" vspace="6" hspace="6"></a>
            <a href="<webflow:createWebflowURL namespace='security' event='link.set_password' />">
<img src="<webflow:createResourceURL resource='<%=imagesPath + "setpassword.gif"%>'/>" border="0" vspace="6"hspace="0"></a>
            <a href="<webflow:createWebflowURL namespace="security" event="link.logout"/>">
<img src="<webflow:createResourceURL resource='<%=imagesPath + "logout.gif"%>'/>" border="0" vspace="6"hspace="6"></a>
        </td>
<%
    }
    else
    {
%>
        <td class="titlebar" align="right">
            <a href="<webflow:createWebflowURL namespace="security" event='link.login' />"><img src="<webflow:createResourceURL resource='<%=imagesPath + "login.gif"%>'/>" border="0" vspace="3" hspace="5"></a>
        </td>
<%
    }
%>
</tr>
</table>

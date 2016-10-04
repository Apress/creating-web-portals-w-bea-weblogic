<%@ page import="java.util.*" %>
<%
	Enumeration rEnum = request.getAttributeNames();
%>
<h2>Request Attributes</h2>
<p>
<TABLE BORDER="1" WIDTH="100%" BGCOLOR="lightgrey">
	<TR>
		<TD WIDTH="50%">
			<P ALIGN="CENTER"><B>Name</B>
		</TD>
		<TD WIDTH="50%">
			<P ALIGN="CENTER"><B>Value</B>
		</TD>
	</TR>
<%
	while (rEnum.hasMoreElements()) {
%>
	<TR>
		<% String name = (String )rEnum.nextElement(); %>
		<TD WIDTH="50%"><%= name %></TD>
		<TD WIDTH="50%"><%= request.getAttribute(name) %></TD>
		
	</TR>
<%
	}
%>
	<TR>
		<TD WIDTH="50%">getRemoteUser()</TD>
		<TD WIDTH="50%"><%= request.getRemoteUser() %></TD>
	</TR>

</TABLE>


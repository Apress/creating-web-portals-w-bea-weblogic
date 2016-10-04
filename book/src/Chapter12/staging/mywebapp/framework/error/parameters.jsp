<%@ page import="java.util.*" %>
<%
	Enumeration enum = request.getParameterNames();
%>
<H2>Request Parameters</h2>
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
	while (enum.hasMoreElements()) {
%>
	<TR>
		<% String name = (String )enum.nextElement(); %>
		<TD WIDTH="50%"><%= name %></TD>
		<TD WIDTH="50%"><%= request.getParameter(name) %></TD>
		
	</TR>
<%
	}
%>
</TABLE>


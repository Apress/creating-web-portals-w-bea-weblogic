<!-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. -->
<%@ page import="java.util.*" %>
<%
	String[] valueName = session.getValueNames();
%>

<H2>Session Attributes</h2>
<TABLE BORDER="1" WIDTH="100%" BGCOLOR="lightgrey">
	<TR>
		<TD WIDTH="50%">
			<P ALIGN="CENTER"><B>Name</B>
		</TD>
		<TD WIDTH="50%">
			<P ALIGN="CENTER"><B>Value</B>
		</TD>
	</TR>
	<TR>
		<TD WIDTH="50%">Session ID</TD>
		<TD WIDTH="50%"><%= session.getId() %></TD>
	</TR>
	<TR>
		<TD WIDTH="50%">Is New</TD>
		<TD WIDTH="50%"><%= session.isNew() %></TD>
	</TR>



<%
	for (int i = 0; i < valueName.length; i++) {
%>
	<TR>
		<TD WIDTH="50%"><%= valueName[i] %></TD>
		<TD WIDTH="50%"><%= session.getValue(valueName[i]) %></TD>
	</TR>
<%
	}
%>
</TABLE>


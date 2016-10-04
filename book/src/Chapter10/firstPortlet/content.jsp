<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="com.wlpbook.ejb.*"%>

<%
     // Declare the names ArrayList
     ArrayList names = null;

     // Get the initial context
     Context initialContext = new InitialContext();

     // Get the presidents home object from the initial context
     PresidentsHome presidentsHome = 
          (PresidentsHome) initialContext.lookup("com.wlpbook.ejb.Presidents");

     // Get the presidents remote object
     Presidents presidents = presidentsHome.create();

     // Use the remote object to call the ejb method
     names = presidents.getData();

%>

<table width=100%>
<%

String rowclass = "row1";
String item = null;

Iterator i = names.iterator();
while (i.hasNext()) {
          item = (String)i.next();

%>
<tr class='<%=rowclass%>'><td><%= item %></td></tr>

<%
	// Alternate row class
	if(rowclass.equals("row1")){
		rowclass = "row2";
	}
	else{
		rowclass = "row1";
	}
}
%>
</table>

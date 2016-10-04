<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="com.wlpbook.util.*"%>
<%@ page import="com.beasys.commerce.axiom.util.helper.JNDIHelper"%>
<%

	// Declare the names ArrayList
	ArrayList names = null;

	// Get the presidents remote object
      Presidents presidents = new Presidents();

	// Use the remote object to call the ejb method
      names = presidents.getData();

%>

<table width=100%>
<%

String rowclass = "row1";
String item = null;

int len = names.size();
System.out.println("size=" + len);
for(int i=0; i< len; i++){
	item = (String) names.get(i);
        System.out.println("item=" + item);
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
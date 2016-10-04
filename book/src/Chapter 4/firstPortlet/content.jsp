<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
    ArrayList names = new ArrayList();

    String item = null;
    String rowclass = "row1";

    // Retrieve name list
      String record = null;

      BufferedReader br = null;
      try {

         InputStreamReader fr = new InputStreamReader(
application.getResourceAsStream("/portlets/firstPortlet/presidents.txt"), "ASCII");
         br = new BufferedReader(fr);

         while ((record = br.readLine()) != null) {
            names.add(record);
         }
      } catch (IOException e) {
         // catch possible io errors from readLine()
         System.out.println("IOException error!");
         e.printStackTrace();
      }
      finally
      {
          try { if (br != null) br.close(); } catch (IOException ignore) { }
      }
%>
<table width=100%>
<%
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

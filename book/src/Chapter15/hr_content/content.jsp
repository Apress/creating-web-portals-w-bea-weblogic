<!-- put the contents of your portlet here -->
<%@ page import="java.sql.*" %>
<%@ page import=”javax.sql.DataSource”%>
<%@ page import="com.bea.p13n.util.jdbc.JdbcHelper"%>
<%@ page import="com.bea.p13n.util.JndiHelper"%>
<%  
    String name = null;
    String job = null;
    Object sal = null;
    String html = null;
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null; 
try{
    DataSource dataSource = (DataSource)JndiHelper.lookupNarrow(
        "OrclDataSource", DataSource.class);
    conn = dataSource.getConnection();
    stmt = conn.createStatement();
    stmt.execute("select ename, job, sal from scott.emp");
  %>

<table>
<tr>
<td>Name</td>
<td>Job</td>
<td>Salary</td>
</tr>
  
<%
   rs = stmt.getResultSet();
   while (rs.next()){
      
     name = rs.getString("ENAME");
     job = rs.getString("JOB");
     sal = rs.getObject("SAL");

     html = "<tr><td>" + name + "</td><td>" + job + 
              "</td><td>" + sal.toString() + "</td></tr>"; 

%>

<%=html %>

<%
    }
}
catch (SQLException ex)
{
    out.println("<pre><code>");
    StringWriter str = new StringWriter();
    PrintWriter pw = new PrintWriter(str);
    ex.printStackTrace(pw);
    pw.flush();
    out.println(str.toString());
    out.println("</code></pre>");
}
finally
{
    JdbcHelper.close(rs, stmt, conn);
}
%>

</table>

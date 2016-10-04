<%
  String firstname = "";
  String lastname = "";
  StringBuffer sb = new StringBuffer();

  if (request.getParameter("SUBMIT") != null) {
    boolean isValid = true;

    firstname = request.getParameter("FIRSTNAME");
    lastname = request.getParameter("LASTNAME");
    
    if ((firstname == null) || (firstname.equals(""))) {
      sb.append("First Name is required<BR>");
      isValid = false;
    }

    if ((lastname == null) || (lastname.equals(""))) {
      sb.append("Last Name is required<BR>");
      isValid = false;
    }

    if (isValid) {
      //Perform what ever processing is neccessary
      firstname = "";
      lastname = "";
    }

  }

%>

<form name="PersonForm" method="post" action="/mywebapp/application?pageid=misc">
<table>
  <tr>
    <td colspan="2"><span style="color:red"><%=sb%></span></td>
  </tr>
  <tr>
    <td>First Name:</td>
    <td><input type="text" value="<%=firstname%>" name="FIRSTNAME"></td>
  </tr>
  <tr>
    <td>Last Name:</td>
    <td><input type="text" value="<%=lastname%>" name="LASTNAME"></td>
  </tr>
  <tr>
    <td colspan="2"><input type="submit" value="Submit" name="SUBMIT"></td>
  </tr>
</table>
</form>

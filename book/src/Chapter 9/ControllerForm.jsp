<jsp:useBean id="userBean" class="com.nws.examples.UserBean" scope="request"/>

<form name="userForm" method="post" action="./user">
<table>
  <tr>
    <td colspan="2"><span style="color:red"><%--userBean.getErrorMessage()--%>
      </span></td>
  </tr>
  <tr>
    <td width="25%">First Name:</td>
    <td width="75%"><input type="text" value="<jsp:getProperty name="userBean" 
      property="firstname"/>" name="FIRSTNAME">&nbsp;<span style="color:red">
      <%=userBean.getFieldError("FIRSTNAME")%></span></td>
  </tr>
  <tr>
    <td>Last Name:</td>
    <td><input type="text" value="<jsp:getProperty name="userBean" 
      property="lastname"/>" name="LASTNAME">&nbsp;<span style="color:red">
      <%=userBean.getFieldError("LASTNAME")%></span></td>
  </tr>
  <tr>
    <td>Email:</td>
    <td><input type="text" value="<jsp:getProperty name="userBean" 
      property="email"/>" name="EMAIL">&nbsp;<span style="color:red">
      <%=userBean.getFieldError("EMAIL")%></span></td>
  </tr>
  <tr>
    <td colspan="2"><input type="submit" value="Submit" name="SUBMIT"></td>
  </tr>
</table>
</form>

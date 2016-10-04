<jsp:useBean id="userBean" class="com.nws.examples.UserBean" scope="request"/>

<table>
  <tr>
    <td>First Name:</td>
    <td><jsp:getProperty name="userBean" property="firstname"/></td>
  </tr>
  <tr>
    <td>Last Name:</td>
    <td><jsp:getProperty name="userBean" property="lastname"/></td>
  </tr>
  <tr>
    <td>Email:</td>
    <td><jsp:getProperty name="userBean" property="email"/></td>
  </tr>
</table>

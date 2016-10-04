<%@ page import="java.util.*" %>

<%@ taglib uri="webflow.tld" prefix="wf"%>

<wf:getProperty property="expertise" id="expertise" type="java.util.Collection" scope="request" namespace="userinfo"/>

<% Iterator i = expertise.iterator(); %>

<table>
  <tr>
    <td width="25%">Username:</td>
    <td><wf:getProperty property="username" scope="request" 
      namespace="userinfo"/></td>
  </tr>
  <tr>
    <td>Password:</td>
    <td><wf:getProperty property="displayPassword" scope="request" 
    namespace="userinfo"/></td>
  </tr>
  <tr>
    <td>Marital Status:</td>
    <td><wf:getProperty property="maritalStatus" scope="request" 
    namespace="userinfo"/></td>
  </tr>
  <tr>
    <td>Language Expertise:</td>
    <td><%=i.next()%></td>
  </tr>
<% while (i.hasNext()) { %>
  <tr>
    <td>&nbsp;</td>
    <td><%=i.next()%></td>
  </tr>
<% } %>
  <tr>
    <td>Comments:</td>
    <td><wf:getProperty property="comments" scope="request" 
      namespace="userinfo"/></td>
  </tr>
  <tr>
    <td>Email:</td>
    <td><wf:getProperty property="email" scope="request" 
      namespace="userinfo"/></td>
  </tr>
</table>

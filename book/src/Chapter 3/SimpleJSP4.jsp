<jsp:useBean id="user" scope="request" class="com.nws.samples.UserBean" />

<jsp:setProperty name="user" property="*" />

<jsp:setProperty name="user" property="type" value="INSERT"/>

<% int defaultAge = 0; %>

<jsp:setProperty name="user" property="age" value=<%= defaultAge %> />

<html>
   <body>
      <b>Last Name:</b> <jsp:getProperty name="user" property="firstName" />
      <br>
      <b>First Name:</b> <jsp:getProperty name="user" property="lastName" />
      <br>	
      <b>Age:</b> <jsp:getProperty name="user" property="age" />
      <br>
      <b>Record Type:</b> <jsp:getProperty name="user" property="type" />
   </body>
</html>

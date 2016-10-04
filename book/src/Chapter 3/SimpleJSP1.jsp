<jsp:useBean id="user" scope="request" class="com.nws.samples.UserBean" />

<jsp:setProperty name="user" property="*" />

<html>
   <body>
      <b>Last Name:</b> <jsp:getProperty name="user" property="lastName" />
      <br>
      <b>First Name:</b> <jsp:getProperty name="user" property="firstName" />
      <br>	
      <b>Age:</b> <jsp:getProperty name="user" property="age" />
   </body>
</html>


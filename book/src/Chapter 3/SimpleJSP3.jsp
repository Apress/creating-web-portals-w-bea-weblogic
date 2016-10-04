<jsp:useBean id="user" scope="request" class="com.nws.samples.UserBean" />

<jsp:setProperty name="user" property="firstName" param="A" />
<jsp:setProperty name="user" property="lastName" param="B" />
<jsp:setProperty name="user" property="age" param="C" />

<%

StringBuffer info = new StringBuffer();

info.append(user.getFirstName());
info.append(" ");
info.append(user.getLastName());
info.append(" is ");
info.append(user.getAge());
info.append(" years old.");
%>

<html>
   <body>
      <p><%= info.toString() %></p>
   </body>
</html>

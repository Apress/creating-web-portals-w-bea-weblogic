<%@ taglib uri="cm.tld" prefix="cm"%>

<% 
    // get the content id from the query parameter passed
    String contentId = (String)request.getParameter("contentid");
%> 

<%  // select content based on the content id %>
<cm:selectById contentId="<%=contentId%>" id="doc" /> 

<% // get the property company and then display it %>
<cm:getProperty id="doc" name="company" resultId="company" resultType="java.lang.String"/>

<b>company:</b> <%=company%>
<BR><BR>

<table> <tr><td>

<% // display the content %>
<cm:printDoc id="doc" blockSize="1000" >
</td></tr></table>

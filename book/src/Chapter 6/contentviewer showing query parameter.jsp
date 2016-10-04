<%@ taglib uri="cm.tld" prefix="cm"%>
<% 
    // get the contentid query parameter
    String contentId = (String)request.getParameter("contentid");
%> 

<%  // select content based on the content id %>
<cm:selectById contentId="<%=contentId%>" id="doc" /> 

<table> <tr><td>
<% // display the content %>
<cm:printDoc id="doc" blockSize="1000" >
</td></tr></table>

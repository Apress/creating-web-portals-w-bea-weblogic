<%@ taglib uri="cm.tld" prefix="cm"%>

<% 
    // define the content id
    String contentId = "examples/NuWave/aboutus.html"; 
%>

<%  // select content based on the content id %>
<cm:selectById contentId="<%=contentId%>" id="doc" />
<table> <tr><td>

<% // display the content %>
<cm:printDoc id="doc" blockSize="1000" >

</td></tr></table>

<%------------------------------------------------------------------
Copyright (c) 2000-2002  BEA Systems, Inc.  All rights reserved.
------------------------------------------------------------------%>

<%------------------------------------------------------------------
File: content_selector.jsp
Purpose: Use a content selector to retrieve content and display it.
------------------------------------------------------------------%>

<%@ page import="com.bea.p13n.content.ContentHelper" %>
<%@ page import="com.bea.p13n.content.Content" %>
<%@ page import="com.bea.p13n.content.document.Document" %>
<%@ page import="java.net.URLEncoder" %>

<%@ taglib uri="cm.tld" prefix="cm" %>
<%@ taglib uri="es.tld" prefix="es" %>
<%@ taglib uri="pz.tld" prefix="pz" %>


<%------------------------------------------------------------------
Retrieve the content using the content selector rule specified.
------------------------------------------------------------------%>
<pz:contentSelector rule="AboutUsContentSelector"
  contentHome="<%=ContentHelper.DEF_DOCUMENT_MANAGER_HOME %>"
  id="contentArray" />

<% if (contentArray.length <= 0) contentArray = null; %>

<table align="center" width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="40%">&nbsp;</td>
    <td width="40%">&nbsp;</td>
    <td width="10%">&nbsp;</td>
  </tr>

<%------------------------------------------------------------------
If the content selector does not return any values, display an
appropriate message.
------------------------------------------------------------------%>
  <es:isNull item="<%=contentArray%>">
    <tr>
      <td>&nbsp;</td>
      <td colspan="2">
        <b>Sorry, The content selector did not find content based on Selection Rules.
        <br><br>
        </b>
        
      </td>
      <td>&nbsp;</td>
    </tr>
  </es:isNull>

<%------------------------------------------------------------------
If the content selector does return any values, display the Name of 
the Document.
------------------------------------------------------------------%>
  <es:notNull item="<%=contentArray%>">

<%------------------------------------------------------------------
Use the es:forEachInArray tag to iterate over the array of content.
If the content is the band logo, use the cm:printProperty tag to
get the value and display it using the ShowDocServlet.
------------------------------------------------------------------%>
    <es:forEachInArray id="nextDoc"
     array="<%=contentArray%>" type="Content">
      


	<cm:getProperty resultId="contentName" resultType="String"
            		id="nextDoc" name="name" encode="html" />

         <%=contentName%>

      	<es:notNull item="<%=contentName%>">
       
		<table> <tr><td>


			<%  // select content based on the content id from content selector%>
			<cm:selectById contentId="<%=contentName%>" id="doc" /> 

			<%	// display the content %>
			<cm:printDoc id="doc" blockSize="1000" baseHref="/ShowDoc" />
		</td></tr></table>        
	</es:notNull>
    </es:forEachInArray>
  </es:notNull>

</table>








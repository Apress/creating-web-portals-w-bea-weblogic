<%@ taglib uri="cm.tld" prefix="cm"%>
<%@ taglib uri="es.tld" prefix="es" %>
<%@ page import="com.bea.p13n.content.document.Document" %>

<% 
    // define the query string 
    String queryStr = "company = 'NuWave Solutions, LLC'"; 
%>

<cm:select query="<%=queryStr%>" id="contentList"/>

<es:forEachInArray id="content" array="<%=contentList%>"
type="com.bea.p13n.content.Content">

    <cm:getProperty resultId="contentName" resultType="String"
    id="content" name="name" encode="html" />

    <br>
    <%= contentName %>
<%  
    }
%>
</es:forEachInArray>  

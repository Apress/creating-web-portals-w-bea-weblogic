<!-- Copyright (c) 2000-2002  BEA Systems, Inc. All Rights Reserved. -->
<%@ page import="com.bea.p13n.appflow.common.internal.AppflowConstants" %>
<%@ page import="com.bea.p13n.appflow.webflow.SessionManagerFactory" %>
<%@ page import="com.bea.p13n.appflow.common.PipelineSession" %>
<%@ page import="java.util.*" %>


<%
    PipelineSession pSess    = SessionManagerFactory.getSessionManager().getPipelineSession(request);
    Object requestContext    = request.getAttribute(AppflowConstants.REQUEST_CONTEXT_ATTRIBUTE_NAME);
%>

<h2>Pipeline Session Attributes</h2>
<p>
<%
    Enumeration     namespaces = pSess.getNamespaceNames();
    while (namespaces.hasMoreElements()) {
        String namespace = (String )namespaces.nextElement();
%>
            <font size="3" color="green">Session Attributes For Namespace: <%= namespace %></font>
        <TABLE BORDER="1" WIDTH="100%" BGCOLOR="lightgrey">
        <TR>
            <TD WIDTH="20%">
                <P ALIGN="CENTER"><B>Name</B>
            </TD>
            <TD WIDTH="80%">
                <P ALIGN="CENTER"><B>Value</B>
            </TD>
        </TR>
<%
        Hashtable sMap = pSess.getSessionScopedAttributeMap(namespace);
        Enumeration sKeys = sMap.keys();
        while (sKeys.hasMoreElements()) {
            String key = (String )sKeys.nextElement();
            Object obj = sMap.get(key);
%>
        <TR>
            <TD WIDTH="20%"><%= key %></TD>
            <TD WIDTH="80%"><%= obj %></TD>
        </TR>
<%
        }
%>
        </TABLE>
<%
    }
%>
<h2Pipeline Request Attributes</h2>
<p>

<%
    namespaces = pSess.getNamespaceNames();
    while (namespaces.hasMoreElements()) {
        String namespace = (String )namespaces.nextElement();
%>
            <font size="3" color="green">Request Attributes For Namespace: <%= namespace %></font>
        <TABLE BORDER="1" WIDTH="100%" BGCOLOR="lightgrey">
        <TR>
            <TD WIDTH="20%">
                <P ALIGN="CENTER"><B>Name</B>
            </TD>
            <TD WIDTH="80%">
                <P ALIGN="CENTER"><B>Value</B>
            </TD>
        </TR>
<%
      if( requestContext != null ) {
        Hashtable sMap = pSess.getRequestScopedAttributeMap(namespace, requestContext);
        if (sMap != null) {
            Enumeration sKeys = sMap.keys();
            while (sKeys.hasMoreElements()) {
                String key = (String )sKeys.nextElement();
                Object obj = sMap.get(key);
%>
            <TR>
                <TD WIDTH="20%"><%= key %></TD>
                <TD WIDTH="80%"><%= obj %></TD>
            </TR>
<%
            }
        }
      }
      else
      {
%>
          <TR><TD>The requestContext is null </TD></TR>
<%
      }
%>
        </TABLE>
        
<%
    }
%>



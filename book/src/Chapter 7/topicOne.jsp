<%@ taglib uri="portlet.tld" prefix="portlet"%>

<h3>Topic One</h3>

<br>
This is Help Topic One.  Use the links below to navigate to the next topic, or to return the Help Contents.

<table>
  <tr>
    <td><a href="<portlet:createWebflowURL namespace="help" event='link.next'/>">Next</a></td>
  </tr>
  <tr>
    <td><a href="<portlet:createWebflowURL namespace="help" event='link.contents'/>">Help Contents</a></td>
  </tr>
</table>

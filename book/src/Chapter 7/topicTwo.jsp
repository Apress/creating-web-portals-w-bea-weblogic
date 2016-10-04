<%@ taglib uri="portlet.tld" prefix="portlet"%>

<h3>Topic Two</h3>

<br>
This is Help Topic Two.  Use the links below to navigate back to the previous topic, or to return the Help Contents.

<table>
  <tr>
    <td><a href="<portlet:createWebflowURL namespace="help" event='link.back'/>">Back</a></td>
  </tr>
  <tr>
    <td><a href="<portlet:createWebflowURL namespace="help" event='link.contents'/>">Help Contents</a></td>
  </tr>
</table>

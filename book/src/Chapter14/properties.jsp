<%@ taglib uri="um.tld" prefix="um" %>
<%@ taglib uri="weblogic.tld" prefix="wl" %>
<%@ taglib uri="ps.tld" prefix="ps" %>
<%@ taglib uri="es.tld" prefix="es" %>
<%@ taglib uri="webflow.tld" prefix="webflow" %>
<%@ page import="com.bea.p13n.usermgmt.servlets.jsp.taglib.UserManagementTagConstants" %>
<%@ page import="com.bea.p13n.property.servlets.jsp.taglib.PropertySetTagConstants" %>
<%@ page import="java.security.Principal" %>
<%@ page import="com.bea.p13n.tracking.TrackingEventHelper"%>

<%
  // check to see if the user is logged in.
  java.security.Principal pr = request.getUserPrincipal();

  if ( pr == null )
  {
%>
    <b>Sorry, but you must log in for this example to work.</b>
<%
      return;
  }
%>

<%
   // get the user name
   String userName = pr != null ? pr.getName() : null;   
%>

<%------------------------------------------------------------------
Retrieve the current user profile using the <um:getProfile> tag.
The profile is received with a session scope, so that the next time
this tag is invoked, the profile will be available.
------------------------------------------------------------------%>

<um:getProfile scope="session" profileKey="<%= userName %>"/>

<form method="post" action="application?pageid=misc">
<table border="0" cellspacing="0" cellpadding="0" width="100%" class="accent">
  User '<%= userName %>'   <BR><BR>
  

<%------------------------------------------------------------------
Determine whether properties are to be updated.  
------------------------------------------------------------------%>

<%
// get the values entered
String worktypeenter = request.getParameter("worktype");
String worknameenter = request.getParameter("workname");
String emailenter = request.getParameter("email");
       
// don't update workname property if nothing has been entered
if ((worknameenter != null)) {
%>

<um:setProperty propertyName="WorkType" propertySet="WorkUserProfile" 
	value="<%= worktypeenter %>"/>
<%
}
// don't update worktype property if nothing has been entered
if ((worktypeenter != null)) {
%>

<um:setProperty propertyName="WorkName" propertySet="WorkUserProfile" 
	value="<%= worknameenter %>"/>
<%
}
%>      


<%
// don't update worktype property if nothing has been entered
if ((emailenter != null)) {
%>

<um:setProperty propertyName="Email" propertySet="WorkUserProfile" 
	value="<%= emailenter %>"/>
<%
}
%>  
  

<%------------------------------------------------------------------
Retrieve restricted property values for WorkType
------------------------------------------------------------------%>

    <ps:getRestrictedPropertyValues
        propertyName="WorkType"
        propertySetName="WorkUserProfile"
        propertySetType="USER"
        id="worktypeRestrictedValues"
        result="worktypeRestrictedValuesRet"/>


<%------------------------------------------------------------------
Retrieve all of user's property values.
------------------------------------------------------------------%>

<um:getProperty propertyName="WorkType" propertySet="WorkUserProfile" id="work_type"/>
<um:getProperty propertyName="WorkName" propertySet="WorkUserProfile" id="work_name"/>
<um:getProperty propertyName="Email" propertySet="WorkUserProfile" id="email_name"/>

	  <tr>
	    <td>Work Name:</td>
            <td><input type="text" name="workname" value="<%=work_name%>"></td>
	  </tr>
          <tr>
            <td>Work Type: </td>
            <td><select size="1" name="worktype">
	    
              
<%
// make sure that work_type is not null

if (work_type == null)
	work_type = "";
          
// loop and get all restricted values to populate a drop down

for (int i = 0; i < worktypeRestrictedValues.length; i++) {
       	
        String worktypevalue = worktypeRestrictedValues[i];

	// if the retreived value is equal to the restricted value then 
	// that value will be selected
        
	if (work_type.equals(worktypevalue)) {
                       
%>

<option selected value="<%= worktypevalue %>"><%= worktypevalue %></option>
<%
}
else {
%>

<option value="<%= worktypevalue %>"><%= worktypevalue %></option>
<%
	}
}
	// check to see if the user changed a property
        if (worknameenter != null || worktypeenter != null || emailenter != null)
	        TrackingEventHelper.dispatchUserRegistrationEvent(request);
%>

</td>
          </tr>
	  <tr>
            <td>Email:</td>
            <td><input type="text" name="email" value="<%=email_name%>"></td>
          </tr>

                
</table>
<input type="submit" name="sbutton" value="Update">
</form>
<%@ taglib uri="portlet.tld" prefix="pt"%>
<%@ taglib uri="webflow.tld" prefix="wf"%>

<% String textStyle="color: #000000; font-size: 12px; font-family: Arial, Geneva, sans-serif; text-decoration: none;";
%>

<pt:getException/>
<br>
<pt:validatedForm event="userform.submit" namespace="userinfo" applyStyle="field"
  messageAlign="right">
  <table>
    <tr>
      <td width="35%">Username:</td>
      <td><wf:text name="username" size="25" maxlength="25" 
        style="<%=textStyle%>"/></td>
    </tr>
    <tr>
      <td>Password:</td>
      <td><wf:password name="password" size="25" maxlength="25"
        style="<%=textStyle%>"/></td>
    </tr>
    <tr>
      <td>Marital Status:</td>
      <td><wf:radio name="maritalStatus" value="S" checked="true"/> Single</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><wf:radio name="maritalStatus" value="M"/> Married</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><wf:radio name="maritalStatus" value="D"/> Divorced</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><wf:radio name="maritalStatus" value="W"/> Widowed</td>
    </tr>
    <tr>
      <td>Language Expertise:</td>
      <td><wf:select name="expertise" size="3" multiple="true">
          <wf:option value="Java">Java</wf:option>
          <wf:option value="C">C</wf:option>
          <wf:option value="C++">C++</wf:option>
          <wf:option value="Ada">Ada</wf:option>
          <wf:option value="Fortran">Fortran</wf:option>
          <wf:option value="Cobol">Cobol</wf:option>
          </wf:select>
      </td>
    </tr>
    <tr>
      <td>Comments:</td>
      <td><wf:textarea name="comments" cols="30" rows="5" 
        style="<%=textStyle%>"/></td>
    </tr>
    <tr>
      <td>Check to receive Email:</td>
      <td><wf:checkbox name="email" checked="true" value="Y"/></td>
    </tr>
    <tr>
      <td colspan="2" align="right"><input type="submit" value="Save"></td>
    </tr>
  </table>
</pt:validatedForm>


<% String validStyle="background: white; color: black; font-family: Arial"; %>
<% String invalidStyle="color: red; font-style: italic"; %>

<div align="center">
<webflow:validatedForm event="button.login" namespace="security"
             applyStyle="message" messageAlign="right"
             validStyle="<%=validStyle%>"
             invalidStyle="<%=invalidStyle%>"
             unspecifiedStyle="<%=validStyle%>"
>
<br><br><br>
<table border="0" class="contentbgcolor" cellspacing="0" cellpadding="10">
   <tr>
     <td colspan="2" align="right"> 
			<span class="pageheader"><i18n:getMessage messageName='pageTitleLabel'/></span>
     </td>		
     <td align="right"> 
			<a href="<webflow:createWebflowURL namespace="security" event="link.help" />"><i18n:getMessage messageName='help'/></a>			
     </td>
   </tr>		
   <tr>
      <td colspan="3">&nbsp;</td>
    </tr>		
   <tr>
     <td valign="top">
       <table border="0" cellpadding="2" cellspacing="0" valign="top">
       <tr>
         <td colspan="2" align="center" class="contentheading"><i18n:getMessage messageName='existingUsers'/><br>&nbsp;</td>
       </tr>
       <tr>
         <td class="fieldlabel"><i18n:getMessage messageName='userId'/></td>
         <td><webflow:text name="j_username"/></td>
       </tr>
       <tr>
         <td class="fieldlabel"><i18n:getMessage messageName='password'/></td>
         <td><webflow:password name="j_password"/></td>
       </tr>
<%
       if (Security.autoLoginEnabled(request))
       {
%>
           <tr>
             <td class="fieldlabel"><i18n:getMessage messageName='autologin'/></td>
             <td><webflow:checkbox name="autologin" value="true"/></td>
           </tr>
<%
       }
%>
       <tr>
        <td>&nbsp;</td>
        <td align="left"> 
	      <i18n:getMessage messageName='login' id='login'/>
          <input type="submit" value="<%=login%>"/>
        </td>
       </tr>
     </table>
     </td>
	 <!-- spacer between tables -->
	 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
     <td valign="top">
       <table border="0" cellpadding="2" cellspacing="0">
         <tr>
           <td align="center" class="contentheading"><i18n:getMessage messageName='newUsers'/><br>&nbsp;</td>
         </tr>
		<tr>
           <td><span class="fieldlabel">
			 <a href="<webflow:createWebflowURL namespace="security" event="link.newuser"/>"><i18n:getMessage messageName='signUpLink'/></a>
			 <i18n:getMessage messageName='signUpText'/></span>
           </td>
		</tr>
		<tr>
			<td><i18n:getMessage messageName='newUserInfo'/></td></tr>
	   </table>
     </td>
   </tr>
   <tr><td colspan="3">&nbsp;</td></tr>
  </table>
 
  </webflow:validatedForm>

  </div>
<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
<jsp:include page="../footer.jsp"/>
</body>
</html>

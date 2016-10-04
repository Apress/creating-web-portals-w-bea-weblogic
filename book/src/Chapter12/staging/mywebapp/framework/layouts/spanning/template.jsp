<%@ taglib uri='ren.tld' prefix='layout' %>
<layout:placePortletsinPlaceholder placeholders="topleft,topright,right,bottomleft" />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" width="35%">
       <layout:render section='topleft'/>
    </td>
    <td valign="top" width="45%">
       <layout:render section='topright'/>
    </td>
    <td valign="top" rowspan="2" width="20%">
       <layout:render section='right'/>
    </td>
  </tr>
  <tr> 
    <td valign="top" colspan="2">
       <layout:render section='bottomleft'/>
    </td>
  </tr>
</table>

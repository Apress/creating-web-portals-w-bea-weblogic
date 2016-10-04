<%@ taglib uri='ren.tld' prefix='layout' %>
<layout:placePortletsinPlaceholder placeholders="left,right" />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
        <layout:render section='left'/>
    </td>
    <td valign="top">
        <layout:render section='right'/>
    </td>
  </tr>
</table>

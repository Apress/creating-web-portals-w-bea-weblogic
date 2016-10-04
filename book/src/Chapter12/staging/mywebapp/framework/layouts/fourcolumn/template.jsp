<%@ taglib uri='ren.tld' prefix='layout' %>
<layout:placePortletsinPlaceholder placeholders="left,leftcenter,rightcenter,right" />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <TR>
    <TD WIDTH="25%" VALIGN="TOP">
      <layout:render section='left'/>
    </TD>
    <TD WIDTH="25%" VALIGN="TOP">
      <layout:render section='leftcenter'/>
    </TD>
    <TD WIDTH="25%" VALIGN="TOP">
      <layout:render section='rightcenter'/>
    </TD>
    <TD WIDTH="25%" VALIGN="TOP">
      <layout:render section='right'/>
    </TD>
  </TR>
</TABLE>


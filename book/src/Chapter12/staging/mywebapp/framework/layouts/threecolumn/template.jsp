<%@ taglib uri='ren.tld' prefix='layout' %>
<layout:placePortletsinPlaceholder placeholders="left,center,right" />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <TR>
    <TD WIDTH="33%" VALIGN="TOP">
      <layout:render section='left'/>
    </TD>
    <TD WIDTH="33%" VALIGN="TOP">
      <layout:render section='center'/>
    </TD>
    <TD WIDTH="33%" VALIGN="TOP">
      <layout:render section='right'/>
    </TD>
  </TR>
</TABLE>


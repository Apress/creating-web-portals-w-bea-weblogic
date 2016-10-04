<%@ taglib uri='ren.tld' prefix='layout' %>
<layout:placePortletsinPlaceholder placeholders="topleft,topcenter,topright,bottom" />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <TR>
    <TD WIDTH="29%" VALIGN="TOP">
      <layout:render section='topleft'/>
    </TD>
    <TD WIDTH="46%" VALIGN="TOP">
      <layout:render section='topcenter'/>
    </TD>
    <TD WIDTH="25%" VALIGN="TOP">
      <layout:render section='topright'/>
    </TD>
  </TR>
  <TR>
    <TD VALIGN="TOP" COLSPAN=3>
      <layout:render section='bottom'/>
    </TD>
  </TR>
</TABLE>
